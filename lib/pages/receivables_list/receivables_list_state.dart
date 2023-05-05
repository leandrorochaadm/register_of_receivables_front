import 'package:match/match.dart';

part 'receivables_list_state.g.dart';

@match
enum ReceivablesStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class ReceivablesListState {
  final ReceivablesStateStatus status;
  // final List<PeopleModel> peoples;
  final String? errorMessage;

  ReceivablesListState({
    required this.status,
    this.errorMessage,
  });

  const ReceivablesListState.initial()
      : status = ReceivablesStateStatus.initial,
        errorMessage = null;
}
