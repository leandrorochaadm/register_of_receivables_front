import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_of_receivables_front/pages/people_list/people_list_controller.dart';

import '../../data/models/models.dart';
import '../../ui/ui.dart';
import '../widgets/widgets.dart';
import 'people_list_state.dart';

class PeopleListPage extends StatefulWidget {
  const PeopleListPage({Key? key}) : super(key: key);

  @override
  State<PeopleListPage> createState() => _PeopleListPageState();
}

class _PeopleListPageState
    extends BaseState<PeopleListPage, PeopleListController> {
  @override
  void onReady() {
    controller.loadPeoples();
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
                    arguments: PeopleModel.empty()),
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(Icons.add),
              ),
            ),
          ],
          body: PeopleTableWidget(list: state.peoples),
        );
      },
    );
  }
}
