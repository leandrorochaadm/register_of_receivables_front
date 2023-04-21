import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_of_receivables_front/pages/bloc/people_bloc.dart';
import 'package:register_of_receivables_front/pages/people_form_page.dart';

import 'pages/people_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // PeopleBloc()..add(const GetPeoplesEvent(),
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => PeopleBloc()..add(const GetPeoplesEvent())),
      ],
      child: MaterialApp(
        title: 'Cadastro de Recebíveis',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/people_list',
        routes: {
          '/people_list': (context) => const PeopleListPage(),
          '/people_form': (context) => PeopleFormPage(),
        },
      ),
    );
  }
}
