import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:register_of_receivables_front/domain/usecases/usecases.dart';

import 'people_list_state.dart';

class PeopleListController extends Cubit<PeopleListState> {
  final GetPeople getPeople;
  PeopleListController({required this.getPeople})
      : super(const PeopleListState.initial());

  Future<void> loadPeoples() async {
    emit(state.copyWith(status: PeopleListStateStatus.loading));

    try {
      final peoples = await getPeople.findAllPeoples();
      emit(state.copyWith(
          status: PeopleListStateStatus.loaded, peoples: peoples));
    } catch (e, s) {
      log('Erro ao buscar as pessoas', error: e, stackTrace: s);
      emit(state.copyWith(
        status: PeopleListStateStatus.error,
        errorMessage: 'Erro ao buscar as pessoas',
      ));
    }
  }
}
