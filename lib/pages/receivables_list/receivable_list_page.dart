import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_of_receivables_front/data/models/models.dart';
import 'package:register_of_receivables_front/pages/widgets/receivables_table_widget.dart';

import '../../ui/ui.dart';
import '../widgets/widgets.dart';
import 'receivables_list_controller.dart';
import 'receivables_list_state.dart';

class ReceivablesListPage extends StatefulWidget {
  const ReceivablesListPage({Key? key}) : super(key: key);

  @override
  State<ReceivablesListPage> createState() => _ReceivablesListPageState();
}

class _ReceivablesListPageState
    extends BaseState<ReceivablesListPage, ReceivablesListController> {
  @override
  void onReady() {
    // controller.loadPeoples();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceivablesListController, ReceivablesListState>(
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
          title: "Listagem de contas a receber",
          widgets: [
            Tooltip(
              message: 'Cadastrar nova conta',
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/', arguments: null),
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(Icons.add),
              ),
            ),
          ],
          children: [
            ReceivablesTableWidget(list: [
              ReceivableModel(
                type: TypeReceivable.Boleto,
                dateEntry: DateTime(2023),
                dateDue: DateTime(2024),
                client: 'Casa da ração',
                numDoc: '123456',
                value: 15000,
                destiny: 'banco Amazônia',
                seller: 'José',
              ),
              ReceivableModel(
                type: TypeReceivable.Boleto,
                dateEntry: DateTime(2023),
                dateDue: DateTime(2024),
                client: 'Casa da ração',
                numDoc: '123456',
                value: 15000,
                destiny: 'banco Amazônia',
                seller: 'José',
              ),
            ])
          ],
        );
      },
    );
  }
}
