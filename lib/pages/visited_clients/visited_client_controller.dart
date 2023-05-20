import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../domain/usecases/usecases.dart';
import 'visited_client_state.dart';

class VisitedClientController extends Cubit<VisitedClientState> {
  final GetVisitedClients getVisitedClients;
  VisitedClientController(this.getVisitedClients)
      : super(const VisitedClientState.initial());

  loadClient({required String date}) async {
    emit(state.copyWith(status: VisitedClientStateStatus.loading));
    final dateTime = DateTime.parse(date);
    try {
      final clients = await getVisitedClients.findAll(dateTime: dateTime);
      emit(state.copyWith(
        status: VisitedClientStateStatus.loaded,
        visitedClients: clients,
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
