import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../data/models/models.dart';

part 'visited_client_state.g.dart';

@match
enum VisitedClientStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class VisitedClientState extends Equatable {
  final VisitedClientStateStatus status;
  final List<VisitedClientModel> visitedClients;
  final String errorMessage;

  const VisitedClientState({
    required this.status,
    required this.errorMessage,
    required this.visitedClients,
  });

  const VisitedClientState.initial()
      : visitedClients = const [],
        errorMessage = '',
        status = VisitedClientStateStatus.initial;

  @override
  List<Object?> get props => [visitedClients];

  VisitedClientState copyWith({
    List<VisitedClientModel>? visitedClients,
    String? errorMessage,
    VisitedClientStateStatus? status,
  }) {
    return VisitedClientState(
      visitedClients: visitedClients ?? this.visitedClients,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
