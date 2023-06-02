import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/models.dart';
import 'widgets.dart';

class ReceivablesTableWidget extends StatelessWidget {
  const ReceivablesTableWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<ReceivableModel> list;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum recebível cadastrado, clique no botão (+) para cadastrar',
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
        final ReceivableModel Receivables = list[index];
        int overdue = DateTime.now().difference(Receivables.dateDue).inDays;

        return Row(
          children: [
            Expanded(
              child: Wrap(
                runSpacing: 16,
                spacing: 8,
                children: [
                  BodyWidget(
                    width: 200,
                    data: Receivables.formOfPayment.name,
                    label: 'Tipo',
                  ),
                  BodyWidget(
                    width: 950,
                    data:
                        "${Receivables.client.name} (${Receivables.client.nick})",
                    label: 'Cliente',
                  ),
                  BodyWidget(
                    width: 200,
                    data: Receivables.numDoc,
                    label: 'Número',
                  ),
                  BodyWidget(
                    width: 200,
                    data: Receivables.value.toString(),
                    label: 'Valor',
                  ),
                  BodyWidget(
                    width: 400,
                    data: Receivables.seller.name,
                    label: 'Vendedor(a)',
                  ),
                  BodyWidget(
                    width: 300,
                    data: Receivables.destiny,
                    label: 'Destino',
                  ),
                  BodyWidget(
                    width: 300,
                    data: DateFormat('dd/MM/yy').format(Receivables.dateEntry),
                    label: 'Data Entrada',
                  ),
                  BodyWidget(
                    width: 350,
                    data: DateFormat('dd/MM/yy').format(Receivables.dateDue),
                    label: 'Data Vencimento',
                  ),
                  BodyWidget(
                    width: 200,
                    data:
                        "${(Receivables.dateDue.difference(Receivables.dateEntry).inDays)} dias",
                    label: 'Prazo',
                  ),
                  Visibility(
                    visible: Receivables.dateReceiving != null,
                    child: BodyWidget(
                      width: 300,
                      data: DateFormat('dd/MM/yy')
                          .format(Receivables.dateReceiving ?? DateTime.now()),
                      label: 'Pago em',
                    ),
                  ),
                  Visibility(
                    visible: overdue > 0 && Receivables.dateReceiving == null,
                    child: BodyWidget(
                      width: 220,
                      data: "$overdue dias",
                      label: 'Vencido há',
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, "/receivable_form",
                  arguments: Receivables),
              icon: const Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              tooltip: 'Editar cadastro',
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, "/receivable_form",
                  arguments: Receivables.copyWith(id: 0)),
              icon: const Icon(
                Icons.copy,
                color: Colors.grey,
              ),
              tooltip: 'Clonar cadastro',
            ),
          ],
        );
      },
    );
  }
}
