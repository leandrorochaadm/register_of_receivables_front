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
  final int countUserActive;

  const VisitedClientState({
    required this.status,
    required this.errorMessage,
    required this.visitedClients,
    required this.countUserActive,
  });

  const VisitedClientState.initial()
      : visitedClients = const [],
        errorMessage = '',
        status = VisitedClientStateStatus.initial,
        countUserActive = 0;

  @override
  List<Object?> get props => [visitedClients];

  VisitedClientState copyWith({
    List<VisitedClientModel>? visitedClients,
    String? errorMessage,
    VisitedClientStateStatus? status,
    int? countUserActive,
  }) {
    return VisitedClientState(
      visitedClients: visitedClients ?? this.visitedClients,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      countUserActive: countUserActive ?? this.countUserActive,
    );
  }
}
