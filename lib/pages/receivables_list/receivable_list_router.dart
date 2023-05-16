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
          Provider(create: (context) => Container()),
          Provider<GetReceivable>(
              create: (context) =>
                  ApiGetReceivables(dio: context.read<CustomDio>())),
          Provider(
              create: (context) => ReceivablesListController(
                  getReceivable: context.read<GetReceivable>())),
        ],
        child: ReceivablesListPage(),
      );
}
