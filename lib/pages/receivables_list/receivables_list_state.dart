import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../data/models/models.dart';

part 'receivables_list_state.g.dart';

@match
enum ReceivablesStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class ReceivablesListState extends Equatable {
  final ReceivablesStateStatus status;
  final List<ReceivableModel> receivables;
  final double sum;
  final String? errorMessage;

  const ReceivablesListState({
    required this.status,
    required this.receivables,
    this.sum = 0,
    this.errorMessage,
  });

  const ReceivablesListState.initial()
      : status = ReceivablesStateStatus.initial,
        errorMessage = null,
        receivables = const [],
        sum = 0;

  ReceivablesListState copyWith({
    ReceivablesStateStatus? status,
    List<ReceivableModel>? receivables,
    double? sum,
    String? errorMessage,
  }) {
    return ReceivablesListState(
      status: status ?? this.status,
      receivables: receivables ?? this.receivables,
      sum: sum ?? this.sum,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, receivables, sum, errorMessage];
}
