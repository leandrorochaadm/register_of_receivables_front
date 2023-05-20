import 'package:bloc/bloc.dart';

import 'visited_client_state.dart';

class VisitedClientController extends Cubit<VisitedClientState> {
  VisitedClientController() : super(const VisitedClientState.initial());
}
