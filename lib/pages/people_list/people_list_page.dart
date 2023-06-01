import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_of_receivables_front/pages/people_list/people_list_controller.dart';

import '../../data/models/models.dart';
import '../../ui/ui.dart';
import '../widgets/widgets.dart';
import 'people_list_state.dart';

class PeopleListPage extends StatefulWidget {
  PeopleListPage({Key? key}) : super(key: key);
  final peopleEC = TextEditingController();
  final peopleFN = FocusNode();
  late PeopleSimplify peopleSelected = PeopleSimplify.empty();
  final isActiveEC = TextEditingController(text: '1');

  @override
  State<PeopleListPage> createState() => _PeopleListPageState();
}

class _PeopleListPageState
    extends BaseState<PeopleListPage, PeopleListController> {
  @override
  void onReady() {
    controller.loadPeoples(name: '', isActive: widget.isActiveEC.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PeopleListController, PeopleListState>(
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
          title: "Listagem de Clientes e Vendedores",
          header: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pesquisar pelo nome da pessoa ou empresa'),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: widget.peopleEC,
                    onChanged: (value) => controller.loadPeoples(
                        name: value, isActive: widget.isActiveEC.text),
                    decoration: const InputDecoration(
                        hintText: 'Digite o nome da pessoa ou empresa'),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                controller.loadPeoples(
                    name: '', isActive: widget.isActiveEC.text);
                widget.peopleEC.text = '';
              },
              icon: const Icon(Icons.clear),
              tooltip: 'Limpar busca',
            ),
            Column(
              children: [
                const Text('Cliente Ativo'),
                Switch(
                  value: widget.isActiveEC.text == '1',
                  onChanged: (bool value) {
                    setState(() {
                      if (value) {
                        widget.isActiveEC.text = '1';
                      } else {
                        widget.isActiveEC.text = '0';
                      }
                    });
                    controller.loadPeoples(
                        name: widget.peopleEC.text,
                        isActive: widget.isActiveEC.text);
                  },
                ),
              ],
            ),
            const SizedBox(width: 16),
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
              message: 'Cadastrar nova pessoa',
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/people_form',
                    arguments: PeopleModel.news()),
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(Icons.add),
              ),
            ),
          ],
          body: PeopleTableWidget(list: state.peoples),
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${state.peoples.length} ${state.peoples.length > 1 ? 'pessoas foram encontradas' : 'pessoa foi encontrada'}",
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
}
