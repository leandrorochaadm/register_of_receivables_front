import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:register_of_receivables_front/data/models/models.dart';

import '../../domain/usecases/usecases.dart';
import 'receivables_list_state.dart';

class ReceivablesListController extends Cubit<ReceivablesListState> {
  final GetReceivable getReceivable;
  final GetPeoplesClients getPeoplesClients;
  final GetFormOfPayments getFormOfPayments;

  ReceivablesListController({
    required this.getReceivable,
    required this.getPeoplesClients,
    required this.getFormOfPayments,
  }) : super(const ReceivablesListState.initial());

  Future<void> loadReceivables({
    required String dateStart,
    required String dateEnd,
    required PeopleSimplify people,
    required String itsPaid,
    required FormOfPaymentModel formOfPayment,
  }) async {
    emit(state.copyWith(status: ReceivablesStateStatus.loading));

    int dateStartNum = 0;
    int dateEndNum = 0;

    if (dateStart != "0") {
      dateStartNum = DateTime.parse(dateStart).millisecondsSinceEpoch;
    }
    if (dateEnd != "0") {
      dateEndNum = DateTime.parse(dateEnd).millisecondsSinceEpoch;
    }
    final peopleId = people.id;

    if (dateEndNum < dateStartNum) {
      dateEndNum = dateStartNum;
    }

    try {
      final receivables = await getReceivable.findAllReceivables(
        dateStart: dateStartNum,
        dateEnd: dateEndNum,
        peopleId: peopleId,
        itsPaid: int.parse(itsPaid),
        formOfPaymentId: formOfPayment.id,
      );

      emit(state.copyWith(
        status: ReceivablesStateStatus.loaded,
        receivables: receivables.receivables,
        sum: receivables.sum,
      ));
    } catch (e, s) {
      log('Erro ao buscar os recebiveis', error: e, stackTrace: s);
      emit(state.copyWith(
        status: ReceivablesStateStatus.error,
        errorMessage: 'Erro ao buscar os recebiveis',
      ));
    }
  }

  loadClient() async {
    emit(state.copyWith(status: ReceivablesStateStatus.loading));
    try {
      final clients = await getPeoplesClients.findAllPeoplesClients();
      final formOfPayments = await getFormOfPayments.findAll();
      emit(state.copyWith(
        status: ReceivablesStateStatus.loaded,
        clients: clients,
        formOfPayments: [FormOfPaymentModel.all(), ...formOfPayments],
      ));
    } catch (e, s) {
      log('Erro ao buscar opções de clientes ou vendedores',
          error: e, stackTrace: s);
      emit(state.copyWith(
        status: ReceivablesStateStatus.error,
        errorMessage: 'Erro ao buscar opções de clientes ou vendedores',
      ));
    }
  }
}
