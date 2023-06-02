import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';

import '../../data/models/models.dart';
import '../../ui/ui.dart';
import '../widgets/widgets.dart';
import 'receivable_form_controller.dart';
import 'receivable_form_state.dart';

class ReceivableFormPage extends StatefulWidget {
  ReceivableFormPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final idEC = TextEditingController();
  final valueEC = TextEditingController();
  final numDocEC = TextEditingController();
  final dateDueEC = TextEditingController();
  final dateReceivingEC = TextEditingController();
  final phone2EC = TextEditingController();
  final phone3EC = TextEditingController();
  final dateEntryEC = TextEditingController();
  final destinyEC = TextEditingController();
  final addressEC = TextEditingController();
  final obsEC = TextEditingController();
  final isPaidEC = TextEditingController();
  final isSellerEC = TextEditingController();
  final valueFN = FocusNode();
  final clientEC = TextEditingController();
  final peopleFN = FocusNode();
  PeopleSimplify selectedClient = PeopleSimplify.empty();
  FormOfPaymentModel selectedFormOfPayment = FormOfPaymentModel.empty();

  final MaskTextInputFormatter dateFormatter =
      MaskTextInputFormatter(mask: '##/##/##');

  // List<String> listType = <String>[
  //   'Selecione',
  //   TypeReceivable.Boleto.name,
  //   TypeReceivable.Cheque.name,
  //   TypeReceivable.Promissoria.name,
  // ];

  @override
  State<ReceivableFormPage> createState() => _ReceivableFormPageState();
}

class _ReceivableFormPageState
    extends BaseState<ReceivableFormPage, ReceivableFormController> {
  PeopleSimplify _selectedSeller = PeopleSimplify.empty();

  // String _selectedType = 'Selecione';

  @override
  void dispose() {
    widget.formKey.currentState?.dispose();
    widget.idEC.dispose();
    widget.valueEC.dispose();
    widget.numDocEC.dispose();
    widget.dateDueEC.dispose();
    widget.dateEntryEC.dispose();
    widget.dateReceivingEC.dispose();
    widget.destinyEC.dispose();
    widget.addressEC.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    final receivable =
        ModalRoute.of(context)!.settings.arguments as ReceivableModel;
    controller.load();
    widget.idEC.text = receivable.id.toString();
    widget.dateEntryEC.text = receivable.dateEntry.toString();
    widget.dateDueEC.text = receivable.dateDue.toString();
    if (receivable.dateReceiving != null) {
      widget.dateReceivingEC.text = receivable.dateReceiving.toString();
    }
    widget.numDocEC.text = receivable.numDoc;
    widget.valueEC.text = receivable.value.toString();
    widget.destinyEC.text = receivable.destiny;

    _selectedSeller = receivable.seller;
    widget.selectedClient = receivable.client;
    widget.clientEC.text = receivable.client.toString();
    // widget.selectedFormOfPayment = receivable.;

    widget.valueFN.addListener(() {
      if (widget.valueFN.hasFocus) {
        widget.valueEC.selection = TextSelection(
            baseOffset: 0, extentOffset: widget.valueEC.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int expiration = 0;
    int overdue = 0;

    if (widget.dateEntryEC.text.isNotEmpty &&
        widget.dateDueEC.text.isNotEmpty) {
      DateTime dateEntry = DateTime.parse(widget.dateEntryEC.text);
      DateTime dateDue = DateTime.parse(widget.dateDueEC.text);
      expiration = dateDue.difference(dateEntry).inDays;
      expiration = dateDue.difference(dateEntry).inDays;

      overdue = DateTime.now().difference(dateDue).inDays;
    }

    return BlocConsumer<ReceivableFormController, ReceivableFormState>(
        listener: (context, state) => state.status.matchAny(
              any: () => hideLoader(),
              success: () {
                hideLoader();
                showSuccess('Recebível salva com sucesso');

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/receivables_list',
                  ModalRoute.withName('/home'),
                );
              },
              deletedSuccess: () {
                hideLoader();
                showSuccess('Recebível excluido com sucesso');

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/receivables_list',
                  ModalRoute.withName('/home'),
                );
              },
              error: () {
                hideLoader();
                showError(state.errorMessage ?? 'Erro não informado');
              },
            ),
        buildWhen: (previous, current) => current.status.matchAny(
              any: () => false,
              initial: () => true,
              loading: () => true,
              loaded: () => true,
            ),
        builder: (context, state) {
          return BasePageWidget(
            title: "Cadastro de recebíveis",
            header: [
              Tooltip(
                message: 'Voltar para a tela lista de recebíveis',
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20)),
                  child: const Icon(Icons.exit_to_app),
                ),
              ),
              const SizedBox(width: 32),
              ElevatedButton(
                onPressed: () => _showMyDialog(),
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 32),
              ElevatedButton(
                onPressed: () async {
                  final valid =
                      widget.formKey.currentState?.validate() ?? false;
                  if (valid) {
                    widget.formKey.currentState?.save();
                    await controller.registerOrUpdate(
                      id: int.parse(widget.idEC.text),
                      value: double.parse(widget.valueEC.text),
                      formOfPayment: widget.selectedFormOfPayment,
                      client: widget.selectedClient,
                      seller: _selectedSeller,
                      dateDue: DateTime.parse(widget.dateDueEC.text),
                      dateEntry: DateTime.parse(widget.dateEntryEC.text),
                      dateReceiving: widget.dateReceivingEC.text != ''
                          ? DateTime.parse(widget.dateReceivingEC.text)
                          : null,
                      destiny: widget.destinyEC.text,
                      numDoc: widget.numDocEC.text,
                    );
                  }
                },
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(Icons.save),
              )
            ],
            body: Form(
              key: widget.formKey,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.start,
                spacing: 50,
                runSpacing: 50,
                children: [
                  SizedBox(
                    width: 250,
                    child: DropdownButtonFormField<PeopleSimplify>(
                      decoration: const InputDecoration(labelText: "Vendedor"),
                      hint: const Text('Escolha o vendedor'),
                      isExpanded: true,
                      value: _selectedSeller,
                      onChanged: (value) {
                        setState(() {
                          _selectedSeller = value!;
                        });
                      },
                      validator: (PeopleSimplify? value) {
                        if (value == null || value == PeopleSimplify.empty()) {
                          return "Vendedor é obrigatório";
                        }
                        return null;
                      },
                      items: state.sellers.map((PeopleSimplify val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text("${val.name} (${val.nick})"),
                        );
                      }).toList(),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cliente'),
                      SizedBox(
                        width: 400,
                        child: RawAutocomplete<PeopleSimplify>(
                          textEditingController: widget.clientEC,
                          focusNode: widget.peopleFN,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return state.clients.where((PeopleSimplify option) {
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
                              controller: textEditingController,
                              focusNode: focusNode,
                              // onFieldSubmitted: (PeopleModel value) {
                              //   onFieldSubmitted();
                              // },
                              onTap: () => widget.clientEC.selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset:
                                          widget.clientEC.value.text.length),
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
                                          widget.selectedClient = option;
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
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<FormOfPaymentModel>(
                      decoration: const InputDecoration(
                        labelText: "Forma de pagamento",
                      ),
                      hint: const Text('Escolha o forma de pagamento'),
                      value: widget.selectedFormOfPayment,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          widget.selectedFormOfPayment = value!;
                        });
                      },
                      validator: (FormOfPaymentModel? value) {
                        if (value == FormOfPaymentModel.empty() ||
                            value == null) {
                          return "Forma de pagamento é obrigatório";
                        }
                        return null;
                      },
                      items: state.formOfPayments
                          .map((FormOfPaymentModel formOfPayment) {
                        return DropdownMenuItem(
                          value: formOfPayment,
                          child: Text(formOfPayment.name),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: widget.numDocEC,
                      decoration: const InputDecoration(
                        labelText: "Número",
                        hintText: "Digite o número do cheque ou boleto",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: widget.valueEC,
                      focusNode: widget.valueFN,
                      onTap: () => widget.valueEC.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: widget.valueEC.value.text.length),
                      validator: Validatorless.required('Valor obrigatório'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: "Valor",
                        hintText: "Digite o valor",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: widget.destinyEC,
                      decoration: const InputDecoration(
                        labelText: "Destino",
                        hintText: "Digite o destino",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 210,
                    child: Row(
                      children: [
                        Expanded(
                          child: DateTimePicker(
                            controller: widget.dateEntryEC,
                            dateMask: 'dd/MM/yy',
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                            icon: const Icon(Icons.event),
                            dateLabelText: 'Entrada',
                            errorInvalidText: "Entrada inválida",
                            errorFormatText: 'Entrada inválida',
                            // locale: const Locale('pt', 'BR'),
                            onChanged: (_) => setState(() {}),
                            validator: (val) {
                              if (val != null && val != '' && val.isNotEmpty) {
                                final date =
                                    DateFormat('yyyy-MM-dd').parse(val);
                                if (date.day > 0) {
                                  return null;
                                }
                                return "Entrada inválida";
                              }
                              return "Entrada obrigatória";
                            },

                            onSaved: (val) => print(val),
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            widget.dateEntryEC.text = '';
                          }),
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 210,
                    child: Row(
                      children: [
                        Expanded(
                          child: DateTimePicker(
                            controller: widget.dateDueEC,
                            dateMask: 'dd/MM/yy',
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                            icon: const Icon(Icons.event),
                            dateLabelText: 'Vencimento',
                            errorInvalidText: "Vencimento inválido",
                            errorFormatText: 'Vencimento inválido',
                            // locale: const Locale('pt', 'BR'),
                            onChanged: (_) => setState(() {}),
                            validator: (val) {
                              if (val != null && val != '' && val.isNotEmpty) {
                                final date =
                                    DateFormat('yyyy-MM-dd').parse(val);
                                if (date.day > 0) {
                                  return null;
                                }
                                return "Vencimento inválido";
                              }
                              return "Vencimento obrigatório";
                            },
                            onSaved: (val) => print(val),
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            widget.dateDueEC.text = '';
                          }),
                          icon: const Icon(Icons.clear),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 210,
                    child: Row(
                      children: [
                        Expanded(
                          child: DateTimePicker(
                            controller: widget.dateReceivingEC,
                            dateMask: 'dd/MM/yy',
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                            icon: const Icon(Icons.event),
                            dateLabelText: 'Recebimento',
                            errorInvalidText: "Recebimento inválido",
                            errorFormatText: 'Recebimento inválido',
                            // locale: const Locale('pt', 'BR'),
                            onChanged: (_) => setState(() {}),
                            validator: (val) {
                              if (val != null && val != '') {
                                final date =
                                    DateFormat('yyyy-MM-dd').parse(val);
                                if (date.day > 0) {
                                  return null;
                                }
                                return "Recebimento inválido";
                              }
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            widget.dateDueEC.text = '';
                          }),
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: expiration > 0 &&
                        widget.dateEntryEC.text.isNotEmpty &&
                        widget.dateDueEC.text.isNotEmpty,
                    child: Text(
                        "Prazo de:\n$expiration ${expiration > 1 ? 'dias' : 'dia'}"),
                  ),
                  Visibility(
                    visible: widget.dateReceivingEC.text.isEmpty && overdue > 0,
                    child: Text(
                        "Vencido há:\n$overdue ${overdue > 1 ? 'dias' : 'dia'}"),
                  ),
                  Text(
                      "Situação: \n${widget.dateReceivingEC.text.isNotEmpty ? 'Está pago' : 'Não está pago'}")
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja realmente excluir?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () => controller.delReceivable(widget.idEC.text),
            ),
          ],
        );
      },
    );
  }
}
