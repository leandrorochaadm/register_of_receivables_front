import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../data/models/models.dart';

part 'receivable_form_state.g.dart';

@match
enum ReceivableFormStateStatus {
  initial,
  loading,
  loaded,
  register,
  success,
  deletedSuccess,
  error,
}

class ReceivableFormState extends Equatable {
  final ReceivableFormStateStatus status;
  final ReceivableModel receivable;
  final String? errorMessage;
  final List<PeopleSimplify> clients;
  final List<PeopleSimplify> sellers;
  final List<FormOfPaymentModel> formOfPayments;

  const ReceivableFormState({
    required this.status,
    required this.receivable,
    this.errorMessage,
    required this.clients,
    required this.sellers,
    required this.formOfPayments,
  });

  ReceivableFormState.initial()
      : status = ReceivableFormStateStatus.initial,
        receivable = ReceivableModel.empty(),
        errorMessage = null,
        clients = [],
        sellers = [],
        formOfPayments = [];

  @override
  List<Object?> get props => [status, receivable, errorMessage, formOfPayments];

  ReceivableFormState copyWith({
    ReceivableFormStateStatus? status,
    ReceivableModel? receivable,
    String? errorMessage,
    List<PeopleSimplify>? clients,
    List<PeopleSimplify>? sellers,
    List<FormOfPaymentModel>? formOfPayments,
  }) {
    return ReceivableFormState(
      status: status ?? this.status,
      receivable: receivable ?? this.receivable,
      errorMessage: errorMessage ?? this.errorMessage,
      clients: clients ?? this.clients,
      sellers: sellers ?? this.sellers,
      formOfPayments: formOfPayments ?? this.formOfPayments,
    );
  }
}
