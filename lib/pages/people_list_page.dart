import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_of_receivables_front/data/models/people_model.dart';
import 'package:register_of_receivables_front/pages/bloc/people_bloc.dart';

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
                  PeopleListWidget(list: list),
                ],
              ),
            ));
      },
    );
  }
}

class PeopleListWidget extends StatelessWidget {
  const PeopleListWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<PeopleModel> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              HeaderWidget(width: 200, label: 'Nome Fantasia'),
              HeaderWidget(width: 200, label: 'Razão Social'),
              HeaderWidget(width: 200, label: 'CNPJ'),
              HeaderWidget(width: 150, label: 'IE'),
              HeaderWidget(width: 200, label: 'Telefone1'),
              HeaderWidget(width: 200, label: 'Telefone2'),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),
          ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.grey),
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final people = list[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        BodyWidget(
                          label: people.nick,
                          fontWeight: FontWeight.bold,
                        ),
                        BodyWidget(label: people.name),
                        BodyWidget(label: people.cnpj),
                        BodyWidget(
                          label: people.ie,
                          width: 150,
                        ),
                        BodyWidget(label: people.phone1),
                        BodyWidget(label: people.phone2),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.payments_outlined,
                            color: Colors.green,
                          ),
                          tooltip: "Ver contas a receber",
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.brown,
                          ),
                          tooltip: 'Editar cadastro',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final double width;
  final String label;

  const HeaderWidget({
    Key? key,
    required this.width,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  final double width;
  final String label;
  final FontWeight fontWeight;

  const BodyWidget({
    Key? key,
    this.width = 200,
    required this.label,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
