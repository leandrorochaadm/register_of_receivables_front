import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:register_of_receivables_front/domain/usecases/usecases.dart';

import 'people_list_state.dart';

class PeopleListController extends Cubit<PeopleListState> {
  final GetPeople getPeople;
  final GetPeoplesClients getPeoplesClients;

  PeopleListController({
    required this.getPeople,
    required this.getPeoplesClients,
  }) : super(const PeopleListState.initial());

  Future<void> loadPeoples({
    required String name,
    required String isActive,
  }) async {
    emit(state.copyWith(status: PeopleListStateStatus.loading));

    try {
      final peoples =
          await getPeople.findAllPeoples(name: name, isActive: isActive);
      final clients = await getPeoplesClients.findAllPeoplesClients();

      emit(state.copyWith(
        status: PeopleListStateStatus.loaded,
        peoples: peoples,
        clients: clients,
      ));
    } catch (e, s) {
      log('Erro ao buscar os clientes e vendedores', error: e, stackTrace: s);
      emit(state.copyWith(
        status: PeopleListStateStatus.error,
        errorMessage: 'Erro ao buscar os clientes e vendedores',
      ));
    }
  }
}
