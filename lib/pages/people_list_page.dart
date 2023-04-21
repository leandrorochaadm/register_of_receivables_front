import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_of_receivables_front/pages/bloc/people_bloc.dart';

class PeopleListPage extends StatelessWidget {
  const PeopleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleBloc, PeopleState>(
      builder: (context, state) {
        final list = state.allPeople;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Listagem de Clientes'),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final people = list[index];
              return ListTile(
                title: Text(people.name),
                subtitle: Text(people.nick),
              );
            },
          ),
        );
      },
    );
  }
}
