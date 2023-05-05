import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:register_of_receivables_front/data/models/models.dart';

import '../../core/core.dart';
import 'receivable_form_state.dart';

class ReceivableFormController extends Cubit<ReceivableFormState> {
  // final PostReceivable postReceivable;
  // final PutReceivable putReceivable;
  // final DeleteReceivable deleteReceivable;

  ReceivableFormController(
      // {
      // required this.postReceivable,
      // required this.putReceivable,
      // required this.deleteReceivable,
      // }
      )
      : super(ReceivableFormState.initial());

  load(ReceivableModel receivable) {
    emit(state.copyWith(
      receivable: receivable,
      status: ReceivableFormStateStatus.loaded,
    ));
  }

  Future<void> registerOrUpdate(
    String id,
    String name,
    String nick,
    String cnpj,
    String ie,
    String isClient,
    String isSeller,
    String phone1,
    String phone2,
    String phone3,
    String address,
    String obs,
  ) async {
    try {
      emit(state.copyWith(status: ReceivableFormStateStatus.register));
      final Receivable = ReceivableModel.empty();
      if (id == '0') {
        // await postReceivable.createReceivable(Receivable);
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
