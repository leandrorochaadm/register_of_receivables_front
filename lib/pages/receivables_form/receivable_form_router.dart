import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';
import '../../data/usecase/usecase.dart';
import '../../domain/usecases/usecases.dart';
import 'receivable_form_controller.dart';
import 'receivable_form_page.dart';

class ReceivableFormRouter {
  ReceivableFormRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<PostReceivable>(
              create: (context) =>
                  ApiPostReceivables(dio: context.read<CustomDio>())),
          Provider<PutReceivable>(
              create: (context) =>
                  ApiPutReceivables(dio: context.read<CustomDio>())),
          Provider<DeleteReceivable>(
            create: (context) =>
                ApiDeleteReceivables(dio: context.read<CustomDio>()),
          ),
          Provider<GetPeoplesClients>(
            create: (context) =>
                ApiGetPeoplesClients(dio: context.read<CustomDio>()),
          ),
          Provider(
              create: (context) => ReceivableFormController(
                    getPeoplesClients: context.read<GetPeoplesClients>(),
                    postReceivable: context.read<PostReceivable>(),
                    putReceivable: context.read<PutReceivable>(),
                    deleteReceivable: context.read<DeleteReceivable>(),
                  )),
        ],
        child: ReceivableFormPage(),
      );
}
