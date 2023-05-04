import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Provider(
              create: (context) =>
                  PeopleFormController(postPeople: context.read<PostPeople>())),
        ],
        child: PeopleFormPage(),
      );
}
