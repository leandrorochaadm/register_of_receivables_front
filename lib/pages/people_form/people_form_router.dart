import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_of_receivables_front/data/usecase/api_delete_people.dart';

import '../../core/core.dart';
import '../../data/usecase/usecase.dart';
import '../../domain/usecases/usecases.dart';
import 'people_form_controller.dart';
import 'people_form_page.dart';

class PeopleFormRouter {
  PeopleFormRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<PostPeople>(
              create: (context) =>
                  ApiPostPeoples(dio: context.read<CustomDio>())),
          Provider<PutPeople>(
              create: (context) =>
                  ApiPutPeoples(dio: context.read<CustomDio>())),
          Provider<DeletePeople>(
            create: (context) =>
                ApiDeletePeoples(dio: context.read<CustomDio>()),
          ),
          Provider(
              create: (context) => PeopleFormController(
                    postPeople: context.read<PostPeople>(),
                    putPeople: context.read<PutPeople>(),
                    deletePeople: context.read<DeletePeople>(),
                  )),
        ],
        child: PeopleFormPage(),
      );
}
