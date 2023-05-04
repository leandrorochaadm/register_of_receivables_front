import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../data/models/models.dart';

@match
enum PeopleFormStateStatus {
  initial,
  loaded,
  register,
  success,
  error,
}

class PeopleFormState extends Equatable {
  final PeopleFormStateStatus status;
  final PeopleModel people;
  final String? errorMessage;

  const PeopleFormState({
    required this.status,
    required this.people,
    this.errorMessage,
  });

  PeopleFormState.initial()
      : status = PeopleFormStateStatus.initial,
        people = PeopleModel.empty(),
        errorMessage = null;

  @override
  List<Object?> get props => [status, people, errorMessage];

  PeopleFormState copyWith({
    PeopleFormStateStatus? status,
    PeopleModel? people,
    String? errorMessage,
  }) {
    return PeopleFormState(
      status: status ?? this.status,
      people: people ?? this.people,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
