import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_of_receivables_front/data/usecase/api_get_peoples.dart';
import 'package:register_of_receivables_front/pages/people_list/people_list_controller.dart';
import 'package:register_of_receivables_front/pages/people_list/people_list_page.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';

class PeopleListRouter {
  PeopleListRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<GetPeople>(
              create: (context) =>
                  ApiGetPeoples(dio: context.read<CustomDio>())),
          Provider(
              create: (context) =>
                  PeopleListController(getPeople: context.read<GetPeople>()))
        ],
        child: const PeopleListPage(),
      );
}
