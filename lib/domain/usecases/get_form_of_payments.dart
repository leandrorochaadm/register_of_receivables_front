import '../../data/models/models.dart';

abstract class GetFormOfPayments {
  Future<List<FormOfPaymentModel>> findAll();
}
