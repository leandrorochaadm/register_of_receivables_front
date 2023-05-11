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
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/receivable_form',
                  arguments: ReceivableModel.empty(),
                ),
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(Icons.add),
              ),
            ),
          ],
          children: [
            ReceivablesTableWidget(list: [
              ReceivableModel(
                id: 1,
                type: TypeReceivable.Cheque,
                dateEntry: DateTime(2023),
                dateDue: DateTime(2024),
                dateReceiving: DateTime(2024),
                client: const PeopleModel(
                    id: 1,
                    name: "Cliente Nome",
                    nick: "Cliente Fantasia",
                    cnpj: "1",
                    ie: '1',
                    isClient: 1,
                    isSeller: 0,
                    phone1: 'phone1',
                    phone2: 'phone2',
                    phone3: 'phone3',
                    address: 'address',
                    obs: 'obs'),
                numDoc: '123456',
                value: 15000,
                destiny: 'banco Amazônia',
                seller: const PeopleModel(
                    id: 1,
                    name: "Vendedor 1",
                    nick: "Vendedor 1",
                    cnpj: "1",
                    ie: '1',
                    isClient: 0,
                    isSeller: 1,
                    phone1: 'phone1',
                    phone2: 'phone2',
                    phone3: 'phone3',
                    address: 'address',
                    obs: 'obs'),
              ),
              ReceivableModel(
                id: 2,
                type: TypeReceivable.Boleto,
                dateEntry: DateTime(2023),
                dateDue: DateTime(2023, 3),
                dateReceiving: DateTime(2024),
                client: const PeopleModel(
                  id: 1,
                  name: "Cliente Nome",
                  nick: "Cliente Fantasia",
                  cnpj: "1",
                  ie: '1',
                  isClient: 1,
                  isSeller: 0,
                  phone1: 'phone1',
                  phone2: 'phone2',
                  phone3: 'phone3',
                  address: 'address',
                  obs: 'obs',
                ),
                numDoc: '123456',
                value: 15000,
                destiny: 'Nutridani',
                seller: const PeopleModel(
                    id: 1,
                    name: "Vendedor 1",
                    nick: "Vendedor 1",
                    cnpj: "1",
                    ie: '1',
                    isClient: 0,
                    isSeller: 1,
                    phone1: 'phone1',
                    phone2: 'phone2',
                    phone3: 'phone3',
                    address: 'address',
                    obs: 'obs'),
              ),
            ])
          ],
        );
      },
    );
  }
}
