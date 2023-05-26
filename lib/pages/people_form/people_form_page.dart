import 'package:cnpj_cpf_formatter_nullsafety/cnpj_cpf_formatter_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:register_of_receivables_front/pages/people_form/people_form_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../data/models/models.dart';
import '../../ui/ui.dart';
import '../widgets/widgets.dart';
import 'people_form_state.dart';

class PeopleFormPage extends StatefulWidget {
  PeopleFormPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final idEC = TextEditingController();
  final nameEC = TextEditingController();
  final nickEC = TextEditingController();
  final phone1EC = TextEditingController();
  final phone2EC = TextEditingController();
  final phone3EC = TextEditingController();
  final ieEC = TextEditingController();
  final cnpjEC = TextEditingController();
  final addressEC = TextEditingController();
  final obsEC = TextEditingController();
  final isClientEC = TextEditingController();
  final isSellerEC = TextEditingController();

  final MaskTextInputFormatter phoneFormatter =
      MaskTextInputFormatter(mask: '(##) #####-####');

  @override
  State<PeopleFormPage> createState() => _PeopleFormPageState();
}

class _PeopleFormPageState
    extends BaseState<PeopleFormPage, PeopleFormController> {
  PeopleSimplify _selectedSeller = PeopleSimplify.empty();

  @override
  void dispose() {
    widget.formKey.currentState?.dispose();
    widget.idEC.dispose();
    widget.nameEC.dispose();
    widget.nickEC.dispose();
    widget.phone1EC.dispose();
    widget.phone2EC.dispose();
    widget.phone3EC.dispose();
    widget.ieEC.dispose();
    widget.cnpjEC.dispose();
    widget.addressEC.dispose();
    widget.obsEC.dispose();
    widget.isClientEC.dispose();
    widget.isSellerEC.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    final people = ModalRoute.of(context)!.settings.arguments as PeopleModel;
    widget.idEC.text = people.id.toString();
    widget.nameEC.text = people.name;
    widget.nickEC.text = people.nick;
    widget.phone1EC.text = people.phone1;
    widget.phone2EC.text = people.phone2;
    widget.phone3EC.text = people.phone3;
    widget.cnpjEC.text = people.cnpj;
    widget.ieEC.text = people.ie;
    widget.addressEC.text = people.address;
    _selectedSeller = people.seller;
    widget.obsEC.text = people.obs;

    setState(() {
      widget.isClientEC.text = people.isClient.toString();
      widget.isSellerEC.text = people.isSeller.toString();
    });

    controller.load(people);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PeopleFormController, PeopleFormState>(
        listener: (context, state) => state.status.matchAny(
              any: () => hideLoader(),
              success: () {
                hideLoader();
                showSuccess('Pessoa salva com sucesso');

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/people_list',
                  ModalRoute.withName('/home'),
                );
              },
              deletedSuccess: () {
                hideLoader();
                showSuccess('Pessoa excluida com sucesso');

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/people_list',
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
              loaded: () => true,
            ),
        builder: (context, state) {
          return BasePageWidget(
            title: "Cadastro de Clientes e Vendedores",
            header: [
              Tooltip(
                message: 'Voltar para a tela lista de Clientes',
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
                    await controller.registerOrUpdate(
                      widget.idEC.text,
                      widget.nameEC.text,
                      widget.nickEC.text,
                      widget.cnpjEC.text,
                      widget.ieEC.text,
                      widget.isClientEC.text,
                      widget.isSellerEC.text,
                      widget.phone1EC.text,
                      widget.phone2EC.text,
                      widget.phone3EC.text,
                      widget.addressEC.text,
                      _selectedSeller,
                      widget.obsEC.text,
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
                    width: 300,
                    child: TextFormField(
                      controller: widget.nickEC,
                      decoration: const InputDecoration(
                        labelText: "Nome Fantasia / Apelido",
                        hintText: "Digite o nome fantasia ou apelido",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: widget.nameEC,
                      validator: Validatorless.required('Nome obrigatório'),
                      decoration: const InputDecoration(
                        labelText: "Razão social / Nome",
                        hintText: "Digite a razão social ou o nome",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      /*inputFormatters: widget.cnpjEC.text.length < 11
                            ? [widget.cpfFormatter]
                            : [widget.cnpjFormatter],*/
                      /*inputFormatters: [
                          widget.cpfFormatter,
                          widget.cnpjFormatter
                        ],*/
                      inputFormatters: [
                        CnpjCpfFormatter(eDocumentType: EDocumentType.BOTH)
                      ],
                      controller: widget.cnpjEC,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "CNPJ / CPF",
                        hintText: "Digite o CNPJ ou CPF",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: widget.ieEC,
                      decoration: const InputDecoration(
                        labelText: "IE / RG",
                        hintText: "Digite a IE ou RG",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 183.3,
                    child: TextFormField(
                      controller: widget.phone1EC,
                      validator: Validatorless.multiple([
                        Validatorless.required('Telefone obrigatório'),
                        Validatorless.min(9, 'Telefone inválido'),
                      ]),
                      inputFormatters: [widget.phoneFormatter],
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Telefone1",
                        hintText: "Digite o telefone (69) 99999-9999",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 183.3,
                    child: TextFormField(
                      controller: widget.phone2EC,
                      inputFormatters: [widget.phoneFormatter],
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Telefone2",
                        hintText: "Digite o telefone",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 183.3,
                    child: TextFormField(
                      controller: widget.phone3EC,
                      inputFormatters: [widget.phoneFormatter],
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Telefone3",
                        hintText: "Digite o telefone",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 550,
                    child: TextFormField(
                      controller: widget.addressEC,
                      decoration: const InputDecoration(
                        labelText: "Endereço",
                        hintText: "Digite o endereço",
                      ),
                    ),
                  ),
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
                  SizedBox(
                    width: 650,
                    child: TextFormField(
                      controller: widget.obsEC,
                      decoration: const InputDecoration(
                        labelText: "Observações",
                        hintText: "Digite observações",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: widget.isClientEC.text == '1',
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                widget.isClientEC.text = '1';
                              } else {
                                widget.isClientEC.text = '0';
                              }
                            });
                          },
                        ),
                        const Text('Cliente'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: widget.isSellerEC.text == '1',
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                widget.isSellerEC.text = '1';
                              } else {
                                widget.isSellerEC.text = '0';
                              }
                            });
                          },
                        ),
                        const Text('Vendedor'),
                      ],
                    ),
                  ),
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
              onPressed: () => controller.delPeople(widget.idEC.text),
            ),
          ],
        );
      },
    );
  }
}
