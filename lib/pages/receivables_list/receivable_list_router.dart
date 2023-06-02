import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';
import '../../data/usecase/usecase.dart';
import '../../domain/usecases/usecases.dart';
import 'receivable_list_page.dart';
import 'receivables_list_controller.dart';

class ReceivablesListRouter {
  ReceivablesListRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<GetPeoplesClients>(
            create: (context) =>
                ApiGetPeoplesClients(dio: context.read<CustomDio>()),
          ),
          Provider<GetReceivable>(
              create: (context) =>
                  ApiGetReceivables(dio: context.read<CustomDio>())),
          Provider<GetFormOfPayments>(
              create: (context) =>
                  ApiGetFormOfPayments(dio: context.read<CustomDio>())),
          Provider(
              create: (context) => ReceivablesListController(
                    getReceivable: context.read<GetReceivable>(),
                    getPeoplesClients: context.read<GetPeoplesClients>(),
                    getFormOfPayments: context.read<GetFormOfPayments>(),
                  )),
        ],
        child: ReceivablesListPage(),
      );
}
