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
  late PeopleModel peopleSelected = PeopleModel.empty();

  @override
  State<ReceivablesListPage> createState() => _ReceivablesListPageState();
}

class _ReceivablesListPageState
    extends BaseState<ReceivablesListPage, ReceivablesListController> {
  @override
  void onReady() {
    widget.dateStartEC.text =
        DateTime.now().subtract(const Duration(days: 90)).toString();
    widget.dateEndEC.text = DateTime.now().toString();
    _findReceivables();
    controller.loadClient();
  }

  void _findReceivables() {
    controller.loadReceivables(
      dateStart: widget.dateStartEC.text == ''
          ? DateTime.now().subtract(const Duration(days: 365)).toString()
          : widget.dateStartEC.text,
      dateEnd: widget.dateEndEC.text == ''
          ? DateTime.now().add(const Duration(days: 365)).toString()
          : widget.dateEndEC.text,
      people: widget.peopleSelected,
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
          title: "Listagem de\ncontas a receber",
          header: [
            const SizedBox(width: 18),
            _findReceivable(state.clients),
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
                "Total a receber é: R\$ ${state.sum.toStringAsFixed(2)}",
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

  Container _findReceivable(List<PeopleModel> listClient) {
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
                          child: RawAutocomplete<PeopleModel>(
                            textEditingController: widget.peopleEC,
                            focusNode: widget.peopleFN,
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return listClient.where((PeopleModel option) {
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
                              AutocompleteOnSelected<PeopleModel> onSelected,
                              Iterable<PeopleModel> options,
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
                                        final PeopleModel option =
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
                            widget.peopleSelected = PeopleModel.empty();
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
                        dateMask: 'EEE dd/MM/yy',
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Vencimento Inicial',
                        errorInvalidText: "Inicial inválida",
                        errorFormatText: 'Inicial inválida',
                        onChanged: (_) => _findReceivables(),
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
                        dateMask: 'EEE dd/MM/yy',
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Vencimento Final',
                        errorInvalidText: "Final inválida",
                        errorFormatText: 'Final inválida',
                        onChanged: (_) => _findReceivables(),
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
            ],
          ),
        ],
      ),
    );
  }
}
