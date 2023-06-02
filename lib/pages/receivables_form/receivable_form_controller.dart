import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:register_of_receivables_front/data/models/models.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';
import 'receivable_form_state.dart';

class ReceivableFormController extends Cubit<ReceivableFormState> {
  final PostReceivable postReceivable;
  final PutReceivable putReceivable;
  final DeleteReceivable deleteReceivable;
  final GetPeoplesClients getPeoplesClients;
  final GetPeoplesSellers getPeoplesSellers;
  final GetFormOfPayments getFormOfPayments;

  ReceivableFormController({
    required this.postReceivable,
    required this.putReceivable,
    required this.deleteReceivable,
    required this.getPeoplesClients,
    required this.getPeoplesSellers,
    required this.getFormOfPayments,
  }) : super(ReceivableFormState.initial());

  load() async {
    emit(state.copyWith(status: ReceivableFormStateStatus.loading));
    try {
      final clients = await getPeoplesClients.findAllPeoplesClients();
      final sellers = await getPeoplesSellers.findAllPeoplesSellers();
      final formOfPayments = await getFormOfPayments.findAll();
      emit(state.copyWith(
        status: ReceivableFormStateStatus.loaded,
        clients: [PeopleSimplify.empty(), ...clients],
        sellers: [PeopleSimplify.empty(), ...sellers],
        formOfPayments: [FormOfPaymentModel.empty(), ...formOfPayments],
      ));
    } catch (e, s) {
      log('Erro ao buscar opções de clientes, vendedores ou formas de pagamento',
          error: e, stackTrace: s);
      emit(state.copyWith(
        status: ReceivableFormStateStatus.error,
        errorMessage:
            'Erro ao buscar opções de clientes, vendedores ou formas de pagamento',
      ));
    }
  }

  Future<void> registerOrUpdate({
    required int id,
    required double value,
    required String numDoc,
    required DateTime dateDue,
    required DateTime dateEntry,
    DateTime? dateReceiving,
    required String destiny,
    required PeopleSimplify seller,
    required PeopleSimplify client,
    required FormOfPaymentModel formOfPayment,
  }) async {
    try {
      emit(state.copyWith(status: ReceivableFormStateStatus.register));
      final receivable = ReceivableModel(
        numDoc: numDoc,
        dateEntry: dateEntry,
        seller: seller,
        client: client,
        formOfPayment: formOfPayment,
        value: value,
        id: id,
        dateDue: dateDue,
        destiny: destiny,
        dateReceiving: dateReceiving,
      );
      if (id == 0) {
        await postReceivable.createReceivable(receivable);
      } else {
        await putReceivable.updateReceivable(receivable);
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

      await deleteReceivable.deleteReceivable(id);

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
