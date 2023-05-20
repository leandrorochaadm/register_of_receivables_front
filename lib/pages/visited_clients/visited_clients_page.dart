import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/ui.dart';
import '../widgets/widgets.dart';
import 'visited_client_controller.dart';
import 'visited_client_state.dart';

class VisitedClientPage extends StatefulWidget {
  const VisitedClientPage({Key? key}) : super(key: key);

  @override
  State<VisitedClientPage> createState() => _VisitedClientPageState();
}

class _VisitedClientPageState
    extends BaseState<VisitedClientPage, VisitedClientController> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitedClientController, VisitedClientState>(
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
          title: "Listagem de\nclientes visitados",
          header: [
            const SizedBox(width: 18),
            // _findReceivable(state.clients),
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
          ],
          body: Container(
            child: Text(state.visitedClients.toString()),
          ),
          // body: VisitedClientsTableWidget(list: state.VisitedClients),
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Total clientes nesse período: ${state.visitedClients.length}",
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
