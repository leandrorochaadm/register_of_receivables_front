import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/models.dart';
import 'widgets.dart';

class VisitedClientsTableWidget extends StatelessWidget {
  const VisitedClientsTableWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<VisitedClientModel> list;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum cliente não visitado nesse período',
          style: TextStyle(color: Colors.red, fontSize: 24),
        ),
      );
    }
    return ListView.separated(
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Divider(color: Colors.grey),
      ),
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final VisitedClients = list[index];

        return Row(
          children: [
            Expanded(
              child: Wrap(
                runSpacing: 16,
                spacing: 8,
                children: [
                  BodyWidget(
                    width: 200,
                    data: DateFormat('dd/MM/yy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            VisitedClients!.dateEntry!)),
                    label: 'Data da visita',
                  ),
                  BodyWidget(
                    width: 750,
                    data:
                        "${VisitedClients.clientName} (${VisitedClients.clientNick})",
                    label: 'Cliente',
                  ),
                  BodyWidget(
                    width: 750,
                    data:
                        "${VisitedClients.sellerName} (${VisitedClients.sellerNick})",
                    label: 'Vendedor',
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, "/VisitedClient_form",
                  arguments: VisitedClients),
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
