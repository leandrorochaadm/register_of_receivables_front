import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'receivable_list_page.dart';
import 'receivables_list_controller.dart';

class ReceivablesListRouter {
  ReceivablesListRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => Container()),
          // Provider<GetReceivables>(
          //     create: (context) =>
          //         ApiGetReceivables(dio: context.read<CustomDio>())),
          Provider(create: (context) => ReceivablesListController()),
        ],
        child: const ReceivablesListPage(),
      );
}
