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
    return ListView.separated(
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Divider(color: Colors.grey),
      ),
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final people = list[index];
        return Row(
          children: [
            Expanded(
              child: Wrap(
                runSpacing: 16,
                children: [
                  BodyWidget(
                    width: 600,
                    data: people.nick,
                    label: 'Fantasia',
                  ),
                  BodyWidget(
                    width: 600,
                    data: people.name,
                    label: 'Razão Social/Nome',
                  ),
                  /* BodyWidget(
                    width: 380,
                    data: people.cnpj,
                    label: 'CNPJ/CPF',
                  ),
                  BodyWidget(
                    width: 300,
                    data: people.ie,
                    label: 'IE/RG',
                  ),*/
                  BodyWidget(
                    width: 250,
                    data: people.phone1,
                    label: 'Tel1',
                  ),
                  BodyWidget(
                    width: 600,
                    data: people.seller.name,
                    label: 'Vendedor',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                '/receivables_list',
                arguments: people.toPeopleSimplify(),
              ),
              icon: Icon(
                Icons.payments_outlined,
                color: Colors.green[300],
              ),
              tooltip: "Ver contas a receber",
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, "/people_form",
                  arguments: people),
              icon: const Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              tooltip: 'Editar cadastro',
            ),
          ],
        );
      },
    );
  }
}
