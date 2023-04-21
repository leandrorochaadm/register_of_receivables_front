import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_of_receivables_front/pages/bloc/people_bloc.dart';

import 'widgets/widgets.dart';

class PeopleListPage extends StatelessWidget {
  const PeopleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleBloc, PeopleState>(
      builder: (context, state) {
        final list = state.allPeople;
        return Scaffold(
            backgroundColor: Colors.blue[100],
            body: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Listagem de Clientes",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  PeopleTableWidget(list: list),
                ],
              ),
            ));
      },
    );
  }
}
