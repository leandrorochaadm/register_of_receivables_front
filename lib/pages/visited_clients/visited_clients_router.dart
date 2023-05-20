import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_of_receivables_front/domain/usecases/get_visited_clients.dart';

import '../../core/core.dart';
import '../../data/usecase/usecase.dart';
import 'visited_client_controller.dart';
import 'visited_clients_page.dart';

class VisitedClientsRouter {
  VisitedClientsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<GetVisitedClients>(
              create: (context) =>
                  ApiGetVisitedClients(dio: context.read<CustomDio>())),
          Provider(
              create: (context) =>
                  VisitedClientController(context.read<GetVisitedClients>())),
        ],
        child: VisitedClientPage(),
      );
}
