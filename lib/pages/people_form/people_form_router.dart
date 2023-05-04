import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'people_form_controller.dart';
import 'people_form_page.dart';

class PeopleFormRouter {
  PeopleFormRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => PeopleFormController()),
        ],
        child: PeopleFormPage(),
      );
}
