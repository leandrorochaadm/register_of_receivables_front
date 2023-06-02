import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';
import '../../data/usecase/usecase.dart';
import '../../domain/usecases/usecases.dart';
import 'visited_client_controller.dart';
import 'visited_clients_page.dart';

class VisitedClientsRouter {
  VisitedClientsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<GetVisitedClients>(
              create: (context) =>
                  ApiGetVisitedClients(dio: context.read<CustomDio>())),
          Provider<GetCountPeopleActive>(
              create: (context) =>
                  ApiGetCountPeopleActive(dio: context.read<CustomDio>())),
          Provider(
              create: (context) => VisitedClientController(
                    getVisitedClients: context.read<GetVisitedClients>(),
                    getCountPeopleActive: context.read<GetCountPeopleActive>(),
                  )),
        ],
        child: VisitedClientPage(),
      );
}
