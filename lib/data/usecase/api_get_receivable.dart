import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';
import '../models/models.dart';

class ApiGetReceivables implements GetReceivable {
  final CustomDio dio;

  ApiGetReceivables({required this.dio});

  @override
  Future<ReceivablesModel> findAllReceivables({
    required int dateStart,
    required int dateEnd,
    required int peopleId,
  }) async {
    try {
      final response = await dio.get(
          "/receivables?dateStart=$dateStart&dateEnd=$dateEnd&peopleId=$peopleId");

      return ReceivablesModel.fromJson(response.data ?? []);
    } on DioError catch (e, s) {
      log("Erro ao buscar recebiveis", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao buscar recebiveis");
    }
  }
}
