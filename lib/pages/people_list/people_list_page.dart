import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_of_receivables_front/pages/people_list/people_list_controller.dart';

import '../widgets/widgets.dart';

class PeopleListPage extends StatelessWidget {
  const PeopleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleListController, PeopleListState>(
      builder: (context, state) {
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
                  PeopleTableWidget(list: state.peoples),
                ],
              ),
            ));
      },
    );
  }
}
