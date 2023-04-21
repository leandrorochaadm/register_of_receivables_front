import 'package:flutter/material.dart';

import '../../data/models/models.dart';
import 'widgets.dart';

class PeopleTableWidget extends StatelessWidget {
  const PeopleTableWidget({
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
                          icon: Icon(
                            Icons.payments_outlined,
                            color: Colors.green[300],
                          ),
                          tooltip: "Ver contas a receber",
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/people_form"),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
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
