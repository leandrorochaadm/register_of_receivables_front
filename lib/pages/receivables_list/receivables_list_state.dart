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
  final List<PeopleSimplify> clients;
  final List<FormOfPaymentModel> formOfPayments;

  const ReceivablesListState({
    required this.status,
    required this.receivables,
    this.sum = 0,
    this.errorMessage,
    required this.clients,
    required this.formOfPayments,
  });

  const ReceivablesListState.initial()
      : status = ReceivablesStateStatus.initial,
        errorMessage = null,
        receivables = const [],
        sum = 0,
        clients = const [],
        formOfPayments = const [];

  ReceivablesListState copyWith({
    ReceivablesStateStatus? status,
    List<ReceivableModel>? receivables,
    double? sum,
    String? errorMessage,
    List<PeopleSimplify>? clients,
    List<FormOfPaymentModel>? formOfPayments,
  }) {
    return ReceivablesListState(
      status: status ?? this.status,
      receivables: receivables ?? this.receivables,
      sum: sum ?? this.sum,
      errorMessage: errorMessage ?? this.errorMessage,
      clients: clients ?? this.clients,
      formOfPayments: formOfPayments ?? this.formOfPayments,
    );
  }

  @override
  List<Object?> get props =>
      [status, receivables, sum, errorMessage, clients, formOfPayments];
}
