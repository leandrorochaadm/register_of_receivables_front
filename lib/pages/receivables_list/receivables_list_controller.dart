import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../domain/usecases/usecases.dart';
import 'receivables_list_state.dart';

class ReceivablesListController extends Cubit<ReceivablesListState> {
  final GetReceivable getReceivable;
  ReceivablesListController({required this.getReceivable})
      : super(const ReceivablesListState.initial());

  Future<void> loadReceivables(
      {required String dateStart, required String dateEnd}) async {
    emit(state.copyWith(status: ReceivablesStateStatus.loading));
    final dateStartNum = DateTime.parse(dateStart).millisecondsSinceEpoch;
    final dateEndNum = DateTime.parse(dateEnd).millisecondsSinceEpoch;

    try {
      final receivables = await getReceivable.findAllReceivables(
        dateStart: dateStartNum,
        dateEnd: dateEndNum,
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
}
