import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';
import '../models/models.dart';

class ApiGetFormOfPayments implements GetFormOfPayments {
  final CustomDio dio;

  ApiGetFormOfPayments({required this.dio});

  @override
  Future<List<FormOfPaymentModel>> findAll() async {
    try {
      final response = await dio.get('/formOfPayments');
      var list = <FormOfPaymentModel>[];
      for (final formOfPayment in response.data as List) {
        list.add(FormOfPaymentModel.fromJson(formOfPayment));
      }
      return list;
    } on DioError catch (e, s) {
      log("Erro ao buscar formas de pagamento", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao buscar formas de pagamento");
    }
  }
}
