// part of 'people_list_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../data/models/models.dart';

part 'people_list_state.g.dart';

@match
enum PeopleListStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class PeopleListState extends Equatable {
  final PeopleListStateStatus status;
  final List<PeopleModel> peoples;
  final String? errorMessage;
  final List<PeopleSimplify> clients;

  const PeopleListState({
    required this.peoples,
    this.errorMessage,
    required this.status,
    required this.clients,
  });

  const PeopleListState.initial()
      : status = PeopleListStateStatus.initial,
        peoples = const [],
        errorMessage = null,
        clients = const [];

  @override
  List<Object?> get props => [
        status,
        peoples,
        errorMessage,
      ];

  PeopleListState copyWith({
    PeopleListStateStatus? status,
    List<PeopleModel>? peoples,
    String? errorMessage,
    List<PeopleSimplify>? clients,
  }) {
    return PeopleListState(
      status: status ?? this.status,
      peoples: peoples ?? this.peoples,
      errorMessage: errorMessage ?? this.errorMessage,
      clients: clients ?? this.clients,
    );
  }
}
