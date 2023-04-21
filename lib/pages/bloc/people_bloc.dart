import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:register_of_receivables_front/data/models/people_model.dart';
import 'package:register_of_receivables_front/data/usecase/get_people.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  PeopleBloc() : super(PeopleState()) {
    on<GetPeoplesEvent>(_getAll);
  }

  Future<void> _getAll(GetPeoplesEvent event, Emitter<PeopleState> emit) async {
    final getPeople = GetPeople();
    final list = await getPeople.call();
    emit(PeopleState(allPeople: list));
  }
}
