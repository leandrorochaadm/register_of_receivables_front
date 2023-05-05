import 'package:flutter/material.dart';

import 'core/core.dart';
import 'pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Cadastro de Recebíveis',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/receivables_list',
        routes: {
          '/people_list': (context) => PeopleListRouter.page,
          '/people_form': (context) => PeopleFormRouter.page,
          '/receivables_list': (context) => ReceivablesListRouter.page,
        },
      ),
    );
  }
}
