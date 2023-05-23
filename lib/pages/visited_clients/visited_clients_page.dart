import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../ui/ui.dart';
import '../widgets/visited_clients_table_widget.dart';
import '../widgets/widgets.dart';
import 'visited_client_controller.dart';
import 'visited_client_state.dart';

class VisitedClientPage extends StatefulWidget {
  VisitedClientPage({Key? key}) : super(key: key);
  DateTime dateDefault = DateTime.now().subtract(const Duration(days: 90));
  final dateEndEC = TextEditingController(
      text: DateTime.now().subtract(const Duration(days: 90)).toString());
  int daysSearch = 90;

  @override
  State<VisitedClientPage> createState() => _VisitedClientPageState();
}

class _VisitedClientPageState
    extends BaseState<VisitedClientPage, VisitedClientController> {
  @override
  void onReady() {
    // widget.dateEndEC.text =
    //     DateTime.now().subtract(const Duration(days: 90)).toString();
    // controller.loadClient(date: widget.dateEndEC.text);
    setDate(widget.dateEndEC.text);
  }

  void setDate(String date) {
    setState(() {
      controller.loadClient(date: date);
      final dateTime = DateFormat('yyyy-MM-dd').parse(date);
      widget.daysSearch = DateTime.now().difference(dateTime).inDays;
      widget.dateEndEC.text = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitedClientController, VisitedClientState>(
      listener: (context, state) => state.status.matchAny(
        any: () => hideLoader(),
        loading: () => showLoader(),
        error: () {
          hideLoader();
          showError(state.errorMessage ?? 'Erro não informado');
        },
      ),
      buildWhen: (previous, current) => current.status.matchAny(
        any: () => false,
        initial: () => true,
        loaded: () => true,
      ),
      builder: (context, state) {
        return BasePageWidget(
          title: "Listagem de clientes não visitados",
          header: [
            const SizedBox(width: 9),
            Text("${widget.daysSearch} dias"),
            const SizedBox(width: 9),
            SizedBox(
              width: 225,
              child: Row(
                children: [
                  Expanded(
                    child: DateTimePicker(
                      controller: widget.dateEndEC,
                      dateMask: 'EEE dd/MM/yy',
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now(),
                      icon: const Icon(Icons.event),
                      dateLabelText: 'Data Inicial',
                      errorInvalidText: "Inicial inválida",
                      errorFormatText: 'Inicial inválida',
                      onChanged: (value) => setDate(value),
                      validator: (val) {
                        if (val != null && val != '' && val!.isNotEmpty) {
                          final date = DateFormat('yyyy-MM-dd').parse(val);
                          if (date.day > 0) {
                            return null;
                          }
                          return "Inicial inválida";
                        }
                        return "Inicial obrigatória";
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () => setDate(widget.dateDefault.toString()),
                    icon: const Icon(Icons.clear),
                    tooltip: 'Pesquisar data de 90 dias',
                  ),
                ],
              ),
            ),
            Tooltip(
              message: 'Voltar para a tela anterior',
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Icon(Icons.exit_to_app),
              ),
            ),
          ],
          body: VisitedClientsTableWidget(list: state.visitedClients),
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Total clientes nesse período: ${state.visitedClients.length}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blue[900],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
