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

  final MaskTextInputFormatter dateFormatter =
      MaskTextInputFormatter(mask: '##/##/##');

  @override
  State<ReceivableFormPage> createState() => _ReceivableFormPageState();
}

class _ReceivableFormPageState
    extends BaseState<ReceivableFormPage, ReceivableFormController> {
  @override
  void dispose() {
    widget.formKey.currentState?.dispose();
    widget.idEC.dispose();
    widget.valueEC.dispose();
    widget.numDocEC.dispose();
    widget.dateDueEC.dispose();
    widget.phone2EC.dispose();
    widget.phone3EC.dispose();
    widget.dateEntryEC.dispose();
    widget.destinyEC.dispose();
    widget.addressEC.dispose();
    widget.obsEC.dispose();
    widget.isPaidEC.dispose();
    widget.isSellerEC.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    final receivable =
        ModalRoute.of(context)!.settings.arguments as ReceivableModel;
    // widget.idEC.text = receivable.id.toString();
    // widget.nameEC.text = receivable.name;
    // widget.nickEC.text = receivable.nick;
    // widget.phone1EC.text = receivable.phone1;
    // widget.phone2EC.text = receivable.phone2;
    // widget.phone3EC.text = receivable.phone3;
    // widget.cnpjEC.text = receivable.cnpj;
    // widget.ieEC.text = receivable.ie;
    // widget.addressEC.text = receivable.address;
    // widget.obsEC.text = receivable.obs;

    setState(() {
      // widget.isClientEC.text = receivable.isClient.toString();
      // widget.isSellerEC.text = receivable.isSeller.toString();
    });
  }

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    DateTime dateEntry = DateTime.now();
    DateTime dateDue = DateTime.now();
    DateTime dateReceiving = DateTime.now();

    if (widget.dateEntryEC.text.isNotEmpty) {
      dateEntry = DateTime.parse(widget.dateEntryEC.text);
    }
    if (widget.dateDueEC.text.isNotEmpty) {
      dateDue = DateTime.parse(widget.dateDueEC.text);
    }
    if (widget.dateReceivingEC.text.isNotEmpty) {
      dateReceiving = DateTime.parse(widget.dateReceivingEC.text);
    }
    int expiration = dateDue.difference(dateEntry).inDays;

    int overdue = DateTime.now().difference(dateDue).inDays;

    late String _selectedValue = list.first;

    return BlocConsumer<ReceivableFormController, ReceivableFormState>(
        listener: (context, state) => state.status.matchAny(
              any: () => hideLoader(),
              success: () {
                hideLoader();
                showSuccess('Recebível salva com sucesso');

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/receivable_list',
                  ModalRoute.withName('/'),
                );
              },
              deletedSuccess: () {
                hideLoader();
                showSuccess('Recebível excluido com sucesso');

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/receivable_list',
                  ModalRoute.withName('/'),
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
              loaded: () => true,
            ),
        builder: (context, state) {
          return BasePageWidget(
            title: "Cadastro de recebíveis",
            widgets: [
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
                      widget.idEC.text,
                      widget.valueEC.text,
                      widget.numDocEC.text,
                      widget.destinyEC.text,
                      widget.dateEntryEC.text,
                      widget.isPaidEC.text,
                      widget.isSellerEC.text,
                      widget.dateDueEC.text,
                      widget.phone2EC.text,
                      widget.phone3EC.text,
                      widget.addressEC.text,
                      widget.obsEC.text,
                    );
                  }
                },
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(Icons.save),
              )
            ],
            children: [
              Form(
                key: widget.formKey,
                child: SizedBox(
                  // width: 1300,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.spaceBetween,
                    spacing: 50,
                    runSpacing: 50,
                    children: [
                      SizedBox(
                        width: 200,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Vendedor",
                          ),
                          hint: const Text('Escolha o vendedor'),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value != null) {
                              return null;
                            } else {
                              return "Vendedor é obrigatório";
                            }
                          },
                          items: list.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Cliente",
                          ),
                          hint: const Text('Escolha o cliente'),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value != null) {
                              return null;
                            } else {
                              return "Cliente é obrigatório";
                            }
                          },
                          items: list.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Tipo",
                          ),
                          hint: const Text('Escolha o tipo'),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value != null) {
                              return null;
                            } else {
                              return "Tipo é obrigatório";
                            }
                          },
                          items: list.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: widget.numDocEC,
                          decoration: const InputDecoration(
                            labelText: "Numero",
                            hintText: "Digite o número do cheque ou boleto",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: widget.valueEC,
                          validator:
                              Validatorless.required('Valor obrigatório'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
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
                        width: 200,
                        child: DateTimePicker(
                          controller: widget.dateEntryEC,
                          dateMask: 'EEE dd/MM/yy',
                          firstDate: DateTime(2022),
                          lastDate: dateDue,
                          icon: const Icon(Icons.event),
                          dateLabelText: 'Entrada',
                          errorInvalidText: "Entrada inválida",
                          errorFormatText: 'Entrada inválida',
                          // locale: const Locale('pt', 'BR'),
                          onChanged: (_) => setState(() {}),
                          validator: (val) {
                            if (val != null && val != '' && val!.isNotEmpty) {
                              final date = DateFormat('yyyy-MM-dd').parse(val);
                              if (date.difference(DateTime.now()).inDays >= 0) {
                                return null;
                              }
                              return "Entrada inválida";
                            }
                            return "Entrada obrigatória";
                          },
                          onSaved: (val) => print(val),
                        ),
                      ),
                      SizedBox(
                        width: 183.3,
                        child: DateTimePicker(
                          controller: widget.dateDueEC,
                          dateMask: 'EEE dd/MM/yy',
                          firstDate: dateEntry,
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                          icon: const Icon(Icons.event),
                          dateLabelText: 'Vencimento',
                          errorInvalidText: "Vencimento inválido",
                          errorFormatText: 'Vencimento inválido',
                          // locale: const Locale('pt', 'BR'),
                          onChanged: (_) => setState(() {}),
                          validator: (val) {
                            if (val != null && val != '' && val!.isNotEmpty) {
                              final date = DateFormat('yyyy-MM-dd').parse(val);
                              if (date.difference(DateTime.now()).inDays >= 0) {
                                return null;
                              }
                              return "Vencimento inválido";
                            }
                            return "Vencimento obrigatório";
                          },
                          onSaved: (val) => print(val),
                        ),
                      ),
                      SizedBox(
                        width: 183.3,
                        child: DateTimePicker(
                          controller: widget.dateReceivingEC,
                          dateMask: 'EEE dd/MM/yy',
                          firstDate: dateEntry,
                          lastDate: DateTime.now(),
                          icon: const Icon(Icons.event),
                          dateLabelText: 'Recebimento',
                          errorInvalidText: "Recebimento inválido",
                          errorFormatText: 'Recebimento inválido',
                          // locale: const Locale('pt', 'BR'),
                          onChanged: (_) => setState(() {}),
                          validator: (val) {
                            if (val != null && val != '' && val!.isNotEmpty) {
                              final date = DateFormat('yyyy-MM-dd').parse(val);
                              if (date.difference(DateTime.now()).inDays >= 0) {
                                return null;
                              }
                              return "Recebimento inválido";
                            }
                            return "Recebimento obrigatório";
                          },
                          onSaved: (val) => print(val),
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
                        visible:
                            widget.dateReceivingEC.text.isEmpty && overdue > 0,
                        child: Text(
                            "Vencido há:\n$overdue ${overdue > 1 ? 'dias' : 'dia'}"),
                      ),
                    ],
                  ),
                ),
              )
            ],
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
