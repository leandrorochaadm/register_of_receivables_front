import 'package:flutter/material.dart';
import 'package:register_of_receivables_front/pages/people_form/people_form_controller.dart';

import '../../data/models/models.dart';
import '../../ui/ui.dart';
import '../widgets/widgets.dart';

class PeopleFormPage extends StatefulWidget {
  PeopleFormPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
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

  @override
  State<PeopleFormPage> createState() => _PeopleFormPageState();
}

class _PeopleFormPageState
    extends BaseState<PeopleFormPage, PeopleFormController> {
  @override
  void dispose() {
    widget.formKey.currentState?.dispose();
    widget.nameEC.dispose();
    widget.nickEC.dispose();
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
    widget.nameEC.text = people.name;
    widget.nickEC.text = people.nick;
    widget.phone1EC.text = people.phone1;
    widget.phone2EC.text = people.phone2;
    widget.phone3EC.text = people.phone3;
    widget.ieEC.text = people.ie;
    widget.addressEC.text = people.address;
    widget.obsEC.text = people.obs;

    setState(() {
      widget.isClientEC.text = people.isClient.toString();
      widget.isSellerEC.text = people.isSeller.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePageWidget(
      title: "Cadastro de Clientes e Vendedores",
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        tooltip: 'Salvar',
        onPressed: () {
          final valid = widget.formKey.currentState?.validate() ?? false;
          if (valid) {
            print('deu certo');
            print(valid);
          } else {
            print('não deu certo');
            print(valid);
          }

          Navigator.pop(context);
        },
      ),
      children: [
        Form(
          child: SizedBox(
            width: 1300,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.spaceBetween,
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
                    decoration: const InputDecoration(
                      labelText: "Razão social / Nome",
                      hintText: "Digite a razão social ou o nome",
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: widget.cnpjEC,
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
                    decoration: const InputDecoration(
                      labelText: "Telefone1",
                      hintText: "Digite o telefone",
                    ),
                  ),
                ),
                SizedBox(
                  width: 183.3,
                  child: TextFormField(
                    controller: widget.phone2EC,
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
                  height: 48,
                  child: ElevatedButton(
                    style: widget.isClientEC.text == '1'
                        ? ElevatedButton.styleFrom(
                            backgroundColor: Colors.green)
                        : ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        if (widget.isClientEC.text == '1') {
                          widget.isClientEC.text = '0';
                        } else {
                          widget.isClientEC.text = '1';
                        }
                      });
                    },
                    child: Text(
                        "${widget.isClientEC.text == '1' ? 'É' : 'Não é'} Cliente"),
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: widget.isSellerEC.text == '1'
                        ? ElevatedButton.styleFrom(
                            backgroundColor: Colors.green)
                        : ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        if (widget.isSellerEC.text == '1') {
                          widget.isSellerEC.text = '0';
                        } else {
                          widget.isSellerEC.text = '1';
                        }
                      });
                    },
                    child: Text(
                        "${widget.isSellerEC.text == '1' ? 'É' : 'Não é'} vendedor"),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
