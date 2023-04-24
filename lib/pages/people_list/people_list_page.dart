import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_of_receivables_front/pages/people_list/people_list_controller.dart';

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
        return Scaffold(
            backgroundColor: Colors.blue[100],
            body: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Listagem de Clientes",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  PeopleTableWidget(list: state.peoples),
                ],
              ),
            ));
      },
    );
  }
}
