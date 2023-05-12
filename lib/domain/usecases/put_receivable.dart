import 'package:register_of_receivables_front/data/models/models.dart';

abstract class PutReceivable {
  Future<void> updateReceivable(ReceivableModel people);
}
