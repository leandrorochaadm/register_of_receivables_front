import 'package:register_of_receivables_front/data/models/models.dart';

abstract class GetReceivable {
  Future<ReceivablesModel> findAllReceivables({
    required int dateStart,
    required int dateEnd,
    required int peopleId,
    required int itsPaid,
    required int formOfPaymentId,
  });
}
