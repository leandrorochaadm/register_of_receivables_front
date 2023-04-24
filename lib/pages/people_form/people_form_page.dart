import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class PeopleFormPage extends StatefulWidget {
  PeopleFormPage({Key? key}) : super(key: key);
  List<bool> PeopleSelectedType = <bool>[true, false];
  final formKey = GlobalKey<FormState>();

  @override
  State<PeopleFormPage> createState() => _PeopleFormPageState();
}

class _PeopleFormPageState extends State<PeopleFormPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageWidget(
      title: "Cadastro de Clientes e Vendedores",
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        tooltip: 'Salvar',
        onPressed: () {
          if (widget.formKey.currentState!.validate()) {}
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
                    decoration: const InputDecoration(
                      labelText: "Nome Fantasia / Apelido",
                      hintText: "Digite o nome fantasia ou apelido",
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Razão social / Nome",
                      hintText: "Digite a razão social ou o nome",
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "CNPJ / CPF",
                      hintText: "Digite o CNPJ ou CPF",
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "IE / RG",
                      hintText: "Digite a IE ou RG",
                    ),
                  ),
                ),
                SizedBox(
                  width: 183.3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Telefone1",
                      hintText: "Digite o telefone",
                    ),
                  ),
                ),
                SizedBox(
                  width: 183.3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Telefone2",
                      hintText: "Digite o telefone",
                    ),
                  ),
                ),
                SizedBox(
                  width: 183.3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Telefone3",
                      hintText: "Digite o telefone",
                    ),
                  ),
                ),
                SizedBox(
                  width: 550,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Endereço",
                      hintText: "Digite o endereço",
                    ),
                  ),
                ),
                SizedBox(
                  width: 650,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Observações",
                      hintText: "Digite observações",
                    ),
                  ),
                ),
                ToggleButtons(
                  isSelected: widget.PeopleSelectedType,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.blue[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.blue[200],
                  color: Colors.blue[400],
                  borderWidth: 2,
                  onPressed: (int index) {
                    setState(() {
                      widget.PeopleSelectedType[index] =
                          !widget.PeopleSelectedType[index];
                    });
                  },
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Cliente'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Vendedor'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
