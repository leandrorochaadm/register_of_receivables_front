import 'package:bloc/bloc.dart';

import 'receivables_list_state.dart';

class ReceivablesListController extends Cubit<ReceivablesListState> {
  ReceivablesListController() : super(const ReceivablesListState.initial());
}
