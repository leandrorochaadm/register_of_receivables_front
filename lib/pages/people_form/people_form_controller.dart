import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:register_of_receivables_front/data/models/models.dart';
import 'package:register_of_receivables_front/pages/people_form/people_form_state.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';

class PeopleFormController extends Cubit<PeopleFormState> {
  final PostPeople postPeople;
  final PutPeople putPeople;
  final DeletePeople deletePeople;

  PeopleFormController({
    required this.postPeople,
    required this.putPeople,
    required this.deletePeople,
  }) : super(PeopleFormState.initial());

  load(PeopleModel people) {
    emit(state.copyWith(people: people, status: PeopleFormStateStatus.loaded));
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
      emit(state.copyWith(status: PeopleFormStateStatus.register));
      final people = PeopleModel(
        id: int.parse(id),
        name: name,
        nick: nick,
        cnpj: cnpj,
        ie: ie,
        isClient: int.parse(isClient),
        isSeller: int.parse(isSeller),
        phone1: phone1,
        phone2: phone2,
        phone3: phone3,
        address: address,
        obs: obs,
      );
      if (id == '0') {
        await postPeople.createPeople(people);
      } else {
        await putPeople.updatePeople(people);
      }

      emit(state.copyWith(status: PeopleFormStateStatus.success));
    } on RepositoryException catch (e, s) {
      log('Erro ao registrar ou atualizar usuário', error: e, stackTrace: s);
      emit(state.copyWith(
          status: PeopleFormStateStatus.error, errorMessage: e.message));
    } catch (e, s) {
      log('Erro ao registrar ou atualizar usuário', error: e, stackTrace: s);
      emit(state.copyWith(status: PeopleFormStateStatus.error));
    }
  }

  Future<void> delPeople(String id) async {
    try {
      emit(state.copyWith(status: PeopleFormStateStatus.register));

      await deletePeople.deletePeople(id);

      emit(state.copyWith(status: PeopleFormStateStatus.success));
    } on RepositoryException catch (e, s) {
      log('Erro ao excluir pessoa', error: e, stackTrace: s);
      emit(state.copyWith(
          status: PeopleFormStateStatus.error, errorMessage: e.message));
    } catch (e, s) {
      log('Erro ao excluir pessoa', error: e, stackTrace: s);
      emit(state.copyWith(status: PeopleFormStateStatus.error));
    }
  }
}
