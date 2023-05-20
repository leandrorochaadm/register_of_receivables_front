import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'visited_client_controller.dart';
import 'visited_clients_page.dart';

class VisitedClientsRouter {
  VisitedClientsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          /* Provider<GetPeoplesClients>(
            create: (context) =>
                ApiGetPeoplesClients(dio: context.read<CustomDio>()),
          ),
          Provider<GetReceivable>(
              create: (context) =>
                  ApiGetReceivables(dio: context.read<CustomDio>())),*/
          Provider(create: (context) => VisitedClientController()),
        ],
        child: const VisitedClientPage(),
      );
}
