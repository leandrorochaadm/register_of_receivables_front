import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../data/models/models.dart';

part 'people_form_state.g.dart';

@match
enum PeopleFormStateStatus {
  initial,
  loading,
  loaded,
  register,
  success,
  deletedSuccess,
  error,
}

class PeopleFormState extends Equatable {
  final PeopleFormStateStatus status;
  final PeopleModel people;
  final String? errorMessage;
  final List<PeopleSimplify> sellers;

  const PeopleFormState({
    required this.status,
    required this.people,
    this.errorMessage,
    required this.sellers,
  });

  PeopleFormState.initial()
      : status = PeopleFormStateStatus.initial,
        people = PeopleModel.empty(),
        errorMessage = null,
        sellers = [];

  @override
  List<Object?> get props => [status, people, errorMessage, sellers];

  PeopleFormState copyWith({
    PeopleFormStateStatus? status,
    PeopleModel? people,
    String? errorMessage,
    List<PeopleSimplify>? sellers,
  }) {
    return PeopleFormState(
      status: status ?? this.status,
      people: people ?? this.people,
      errorMessage: errorMessage ?? this.errorMessage,
      sellers: sellers ?? this.sellers,
    );
  }
}
