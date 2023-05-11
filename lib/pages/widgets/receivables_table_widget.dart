import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:register_of_receivables_front/ui/helper/size_extesions.dart';

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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 8,
            children: [
              HeaderWidget(
                width: context.percentWidth(.07),
                label: 'Tipo',
              ),
              HeaderWidget(
                width: context.percentWidth(.25),
                label: 'Cliente',
              ),
              HeaderWidget(
                width: context.percentWidth(.12),
                label: 'Número',
              ),
              HeaderWidget(
                width: context.percentWidth(.12),
                label: 'Valor',
              ),
              HeaderWidget(
                width: context.percentWidth(.12),
                label: 'Vendedor',
              ),
              HeaderWidget(
                width: context.percentWidth(.18),
                label: 'Destino',
              ),
              HeaderWidget(
                width: context.percentWidth(.15),
                label: 'Entrada',
              ),
              HeaderWidget(
                width: context.percentWidth(.15),
                label: 'Vencimento',
              ),
              HeaderWidget(
                width: context.percentWidth(.15),
                label: 'Prazo',
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
              final Receivables = list[index];
              return Row(
                children: [
                  Expanded(
                    child: Wrap(
                      runSpacing: 8,
                      children: [
                        BodyWidget(
                          width: context.percentWidth(.07),
                          label: Receivables.type.name,
                          fontWeight: FontWeight.bold,
                        ),
                        BodyWidget(
                            width: context.percentWidth(.25),
                            label: Receivables.client.name),
                        BodyWidget(
                          width: context.percentWidth(.12),
                          label: Receivables.numDoc,
                        ),
                        BodyWidget(
                            width: context.percentWidth(.12),
                            label: Receivables.value.toString()),
                        BodyWidget(
                            width: context.percentWidth(.12),
                            label: Receivables.seller.name),
                        BodyWidget(
                            width: context.percentWidth(.18),
                            label: Receivables.destiny),
                        BodyWidget(
                            width: context.percentWidth(.15),
                            label: DateFormat('dd/MM/yy')
                                .format(Receivables.dateEntry)),
                        BodyWidget(
                            width: context.percentWidth(.15),
                            label: DateFormat('dd/MM/yy')
                                .format(Receivables.dateDue)),
                        BodyWidget(
                            width: context.percentWidth(.15),
                            label:
                                "${(Receivables.dateDue.difference(Receivables.dateEntry).inDays)} dias"),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(
                        context, "/receivable_form",
                        arguments: Receivables),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    tooltip: 'Editar cadastro',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
