import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:register_of_receivables_front/data/models/models.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';
import 'receivable_form_state.dart';

class ReceivableFormController extends Cubit<ReceivableFormState> {
  final PostReceivable postReceivable;
  // final PutReceivable putReceivable;
  // final DeleteReceivable deleteReceivable;

  ReceivableFormController({
    required this.postReceivable,
    // required this.putReceivable,
    // required this.deleteReceivable,
  }) : super(ReceivableFormState.initial());

  load(ReceivableModel receivable) {
    emit(state.copyWith(
      receivable: receivable,
      status: ReceivableFormStateStatus.loaded,
    ));
  }

  Future<void> registerOrUpdate({
    required int id,
    required double value,
    required String numDoc,
    required DateTime dateDue,
    required DateTime dateEntry,
    required DateTime dateReceiving,
    required String destiny,
    required PeopleModel seller,
    required PeopleModel client,
    required String type,
  }) async {
    try {
      emit(state.copyWith(status: ReceivableFormStateStatus.register));
      final Receivable = ReceivableModel(
        numDoc: numDoc,
        dateEntry: dateEntry,
        seller: seller,
        client: client,
        type: TypeReceivable.Boleto.name == type
            ? TypeReceivable.Boleto
            : TypeReceivable.Cheque,
        value: value,
        id: id,
        dateDue: dateDue,
        destiny: destiny,
        dateReceiving: dateReceiving,
      );
      if (id == '0') {
        await postReceivable.createReceivable(Receivable);
      } else {
        // await putReceivable.updateReceivable(Receivable);
      }

      emit(state.copyWith(status: ReceivableFormStateStatus.success));
    } on RepositoryException catch (e, s) {
      log('Erro ao registrar ou atualizar recebivel', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ReceivableFormStateStatus.error, errorMessage: e.message));
    } catch (e, s) {
      log('Erro ao registrar ou atualizar recebivel', error: e, stackTrace: s);
      emit(state.copyWith(status: ReceivableFormStateStatus.error));
    }
  }

  Future<void> delReceivable(String id) async {
    try {
      emit(state.copyWith(status: ReceivableFormStateStatus.register));

      // await deleteReceivable.deleteReceivable(id);

      emit(state.copyWith(status: ReceivableFormStateStatus.deletedSuccess));
    } on RepositoryException catch (e, s) {
      log('Erro ao excluir recebivel', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ReceivableFormStateStatus.error, errorMessage: e.message));
    } catch (e, s) {
      log('Erro ao excluir recebivel', error: e, stackTrace: s);
      emit(state.copyWith(status: ReceivableFormStateStatus.error));
    }
  }
}
