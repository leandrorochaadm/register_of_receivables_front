import 'package:flutter/material.dart';
import 'package:register_of_receivables_front/pages/people_list/people_list_page.dart';

import 'core/core.dart';
import 'pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Cadastro de Recebíveis',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/people_list',
        routes: {
          '/people_list': (context) => PeopleListPage(),
          '/people_form': (context) => PeopleFormPage(),
        },
      ),
    );
  }
}
