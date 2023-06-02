import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../domain/usecases/usecases.dart';
import 'visited_client_state.dart';

class VisitedClientController extends Cubit<VisitedClientState> {
  final GetVisitedClients getVisitedClients;
  final GetCountPeopleActive getCountPeopleActive;

  VisitedClientController({
    required this.getVisitedClients,
    required this.getCountPeopleActive,
  }) : super(const VisitedClientState.initial());

  loadClient({required String date}) async {
    emit(state.copyWith(status: VisitedClientStateStatus.loading));
    final dateTime = DateTime.parse(date);
    try {
      final clients = await getVisitedClients.findAll(dateTime: dateTime);
      final count = await getCountPeopleActive.countPeopleActive();
      emit(state.copyWith(
        status: VisitedClientStateStatus.loaded,
        visitedClients: clients,
        countUserActive: count,
      ));
    } catch (e, s) {
      log('Erro ao buscar opções de clientes visitados',
          error: e, stackTrace: s);
      emit(state.copyWith(
        status: VisitedClientStateStatus.error,
        errorMessage: 'Erro ao buscar opções de clientes visitados',
      ));
    }
  }
}
