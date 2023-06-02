import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:register_of_receivables_front/data/models/models.dart';
import 'package:register_of_receivables_front/pages/widgets/receivables_table_widget.dart';

import '../../ui/ui.dart';
import '../widgets/widgets.dart';
import 'receivables_list_controller.dart';
import 'receivables_list_state.dart';

class ReceivablesListPage extends StatefulWidget {
  ReceivablesListPage({Key? key}) : super(key: key);

  final dateStartEC = TextEditingController();
  final dateEndEC = TextEditingController();
  final peopleEC = TextEditingController();
  final peopleFN = FocusNode();
  late PeopleSimplify peopleSelected = PeopleSimplify.empty();
  final itsPaidEC = TextEditingController(text: '0');
  late FormOfPaymentModel formOfPaymentSelected = FormOfPaymentModel.all();

  @override
  State<ReceivablesListPage> createState() => _ReceivablesListPageState();
}

class _ReceivablesListPageState
    extends BaseState<ReceivablesListPage, ReceivablesListController> {
  @override
  void onReady() {
    final Object? objectParams = ModalRoute.of(context)!.settings.arguments;
    final PeopleSimplify peopleParams = objectParams != null
        ? objectParams as PeopleSimplify
        : PeopleSimplify.empty();
    if (peopleParams.name.isNotEmpty) {
      widget.peopleSelected = peopleParams;
      widget.peopleEC.text = peopleParams.toString();
    }
    _findReceivables();
    controller.loadClient();
  }

  void _findReceivables() {
    controller.loadReceivables(
      dateStart: widget.dateStartEC.text == '' ? "0" : widget.dateStartEC.text,
      dateEnd: widget.dateEndEC.text == '' ? "0" : widget.dateEndEC.text,
      people: widget.peopleSelected,
      itsPaid: widget.itsPaidEC.text,
      formOfPayment: widget.formOfPaymentSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceivablesListController, ReceivablesListState>(
      listener: (context, state) => state.status.matchAny(
        any: () => hideLoader(),
        loading: () => showLoader(),
        error: () {
          hideLoader();
          showError(state.errorMessage ?? 'Erro não informado');
        },
      ),
      buildWhen: (previous, current) => current.status.matchAny(
        any: () => false,
        initial: () => true,
        loaded: () => true,
      ),
      builder: (context, state) {
        return BasePageWidget(
          title: "Listagem\nde contas",
          header: [
            const SizedBox(width: 18),
            _findReceivable(
              listClient: state.clients,
              listFormOfPayment: state.formOfPayments,
            ),
            const SizedBox(width: 18),
            Tooltip(
              message: 'Voltar para a tela anterior',
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(Icons.exit_to_app),
              ),
            ),
            const SizedBox(width: 32),
            Tooltip(
              message: 'Cadastrar novo recebével',
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/receivable_form',
                  arguments: ReceivableModel.empty(),
                ),
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(Icons.add),
              ),
            ),
          ],
          body: ReceivablesTableWidget(list: state.receivables),
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Somatório dessa pesquisa é: R\$ ${state.sum.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blue[900],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container _findReceivable({
    required List<PeopleSimplify> listClient,
    required List<FormOfPaymentModel> listFormOfPayment,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.blue[900]!),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Text(
            'Pesquisa dos recebíveis:',
            style: TextStyle(color: Colors.blue[900]),
          ),
          Row(
            children: [
              SizedBox(
                width: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cliente:'),
                    Row(
                      children: [
                        Expanded(
                          child: RawAutocomplete<PeopleSimplify>(
                            textEditingController: widget.peopleEC,
                            focusNode: widget.peopleFN,
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return listClient.where((PeopleSimplify option) {
                                return option.toString().toLowerCase().contains(
                                    textEditingValue.text.toLowerCase());
                              });
                            },
                            fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted,
                            ) {
                              return TextFormField(
                                autofocus: true,
                                controller: textEditingController,
                                focusNode: focusNode,
                                // onFieldSubmitted: (PeopleModel value) {
                                //   onFieldSubmitted();
                                // },
                              );
                            },
                            optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<PeopleSimplify> onSelected,
                              Iterable<PeopleSimplify> options,
                            ) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4.0,
                                  child: SizedBox(
                                    height: 500.0,
                                    width: 350,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(8.0),
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final PeopleSimplify option =
                                            options.elementAt(index);
                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);
                                            widget.peopleSelected = option;

                                            _findReceivables();
                                          },
                                          child: ListTile(
                                            title: Text(option.toString()),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            widget.peopleSelected = PeopleSimplify.empty();
                            widget.peopleEC.text = '';
                            FocusScope.of(context)
                                .requestFocus(widget.peopleFN);
                            _findReceivables();
                          }),
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              SizedBox(
                width: 225,
                child: Row(
                  children: [
                    Expanded(
                      child: DateTimePicker(
                        controller: widget.dateStartEC,
                        dateMask: 'dd/MM/yy',
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Vencimento Inicial',
                        errorInvalidText: "Inicial inválida",
                        errorFormatText: 'Inicial inválida',
                        onChanged: (value) {
                          if (widget.dateEndEC.text == "") {
                            widget.dateEndEC.text = widget.dateStartEC.text;
                          }

                          final dateEndEC = widget.dateEndEC.text;
                          if (dateEndEC != "") {
                            final dateInitial =
                                DateFormat('yyyy-MM-dd').parse(value);
                            final dateFinal =
                                DateFormat('yyyy-MM-dd').parse(dateEndEC);

                            final isAfter = dateInitial.isAfter(dateFinal);
                            if (isAfter) {
                              widget.dateEndEC.text = widget.dateStartEC.text;
                            }
                          }
                          _findReceivables();
                        },
                        validator: (val) {
                          if (val != null && val != '' && val!.isNotEmpty) {
                            final date = DateFormat('yyyy-MM-dd').parse(val);
                            if (date.day > 0) {
                              return null;
                            }
                            return "Inicial inválida";
                          }
                          return "Inicial obrigatória";
                        },
                        onSaved: (val) => print(val),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() {
                        widget.dateStartEC.text = '';
                        _findReceivables();
                      }),
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              SizedBox(
                width: 225,
                child: Row(
                  children: [
                    Expanded(
                      child: DateTimePicker(
                        controller: widget.dateEndEC,
                        dateMask: 'dd/MM/yy',
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Vencimento Final',
                        errorInvalidText: "Final inválida",
                        errorFormatText: 'Final inválida',
                        onChanged: (value) {
                          if (widget.dateStartEC.text == "") {
                            widget.dateStartEC.text = widget.dateEndEC.text;
                          }

                          final dateStartEC = widget.dateStartEC.text;
                          if (dateStartEC != "") {
                            final dateInitial =
                                DateFormat('yyyy-MM-dd').parse(dateStartEC);
                            final dateFinal =
                                DateFormat('yyyy-MM-dd').parse(value);

                            final isAfter = dateInitial.isAfter(dateFinal);
                            if (isAfter) {
                              widget.dateStartEC.text = widget.dateEndEC.text;
                            }
                          }
                          _findReceivables();
                        },
                        validator: (val) {
                          if (val != null && val != '' && val!.isNotEmpty) {
                            final date = DateFormat('yyyy-MM-dd').parse(val);
                            if (date.day > 0) {
                              return null;
                            }
                            return "Final inválida";
                          }
                          return "Final obrigatória";
                        },
                        onSaved: (val) => print(val),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() {
                        widget.dateEndEC.text = '';
                        _findReceivables();
                      }),
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                child: DropdownButtonFormField<FormOfPaymentModel>(
                  decoration:
                      const InputDecoration(labelText: "Forma de pagamento"),
                  isExpanded: true,
                  value: widget.formOfPaymentSelected,
                  onChanged: (value) {
                    setState(() {
                      widget.formOfPaymentSelected = value!;
                    });
                    _findReceivables();
                  },
                  items: listFormOfPayment.map((FormOfPaymentModel val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val.name),
                    );
                  }).toList(),
                ),
              ),
              Column(
                children: [
                  const Text('Pagos'),
                  Switch(
                    value: widget.itsPaidEC.text == '1',
                    onChanged: (bool value) {
                      setState(() {
                        if (value) {
                          widget.itsPaidEC.text = '1';
                        } else {
                          widget.itsPaidEC.text = '0';
                        }
                      });
                      _findReceivables();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
