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

  @override
  State<PeopleListPage> createState() => _PeopleListPageState();
}

class _PeopleListPageState
    extends BaseState<PeopleListPage, PeopleListController> {
  @override
  void onReady() {
    controller.loadPeoples('');
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
                const Text('Cliente'),
                SizedBox(
                  width: 400,
                  child: RawAutocomplete<PeopleSimplify>(
                    textEditingController: widget.peopleEC,
                    focusNode: widget.peopleFN,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return state.clients.where((PeopleSimplify option) {
                        return option
                            .toString()
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
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
                              itemBuilder: (BuildContext context, int index) {
                                final PeopleSimplify option =
                                    options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                    widget.peopleSelected = option;

                                    controller.loadPeoples(option.name);
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
            IconButton(
              onPressed: () {
                controller.loadPeoples('');
                widget.peopleEC.text = '';
              },
              icon: const Icon(Icons.clear),
              tooltip: 'Limpar busca',
            ),
            const SizedBox(width: 32),
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
