import 'package:register_of_receivables_front/data/models/models.dart';

abstract class PostReceivable {
  Future<void> createReceivable(ReceivableModel people);
}
