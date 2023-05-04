import 'package:bloc/bloc.dart';
import 'package:register_of_receivables_front/data/models/models.dart';
import 'package:register_of_receivables_front/pages/people_form/people_form_state.dart';

class PeopleFormController extends Cubit<PeopleFormState> {
  PeopleFormController() : super(PeopleFormState.initial());

  load(PeopleModel people) {
    emit(state.copyWith(people: people, status: PeopleFormStateStatus.loaded));
  }
}
