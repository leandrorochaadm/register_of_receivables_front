import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../domain/usecases/usecases.dart';
import 'receivables_list_state.dart';

class ReceivablesListController extends Cubit<ReceivablesListState> {
  final GetReceivable getReceivable;
  ReceivablesListController({required this.getReceivable})
      : super(const ReceivablesListState.initial());

  Future<void> loadReceivables() async {
    emit(state.copyWith(status: ReceivablesStateStatus.loading));

    try {
      final receivables = await getReceivable.findAllReceivables();
      emit(state.copyWith(
        status: ReceivablesStateStatus.loaded,
        receivables: receivables.receivables,
        sum: receivables.sum,
      ));
    } catch (e, s) {
      log('Erro ao buscar os clientes e vendedores', error: e, stackTrace: s);
      emit(state.copyWith(
        status: ReceivablesStateStatus.error,
        errorMessage: 'Erro ao buscar os clientes e vendedores',
      ));
    }
  }
}
