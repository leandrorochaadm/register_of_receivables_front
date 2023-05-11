import 'package:flutter/material.dart';
import 'package:register_of_receivables_front/ui/helper/size_extesions.dart';

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
            children: [
              HeaderWidget(
                width: context.percentWidth(.15),
                label: 'Nome Fantasia',
              ),
              HeaderWidget(
                width: context.percentWidth(.15),
                label: 'Razão Social',
              ),
              HeaderWidget(
                width: context.percentWidth(.18),
                label: 'CNPJ',
              ),
              HeaderWidget(
                width: context.percentWidth(.1),
                label: 'IE',
              ),
              HeaderWidget(
                width: context.percentWidth(.12),
                label: 'Telefone1',
              ),
              HeaderWidget(
                width: context.percentWidth(.12),
                label: 'Telefone2',
              ),
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
                          width: context.percentWidth(.15),
                          data: people.nick,
                        ),
                        BodyWidget(
                            width: context.percentWidth(.15),
                            data: people.name),
                        BodyWidget(
                            width: context.percentWidth(.18),
                            data: people.cnpj),
                        BodyWidget(
                          width: context.percentWidth(.1),
                          data: people.ie,
                        ),
                        BodyWidget(
                            width: context.percentWidth(.12),
                            data: people.phone1),
                        BodyWidget(
                            width: context.percentWidth(.12),
                            data: people.phone2),
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
                          onPressed: () => Navigator.pushNamed(
                              context, "/people_form",
                              arguments: people),
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
