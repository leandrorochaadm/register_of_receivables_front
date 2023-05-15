import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';

class ApiDeleteReceivables implements DeleteReceivable {
  final CustomDio dio;

  ApiDeleteReceivables({required this.dio});

  @override
  Future<void> deleteReceivable(String id) async {
    try {
      await dio.delete('/receivables/$id');
    } on DioError catch (e, s) {
      log("Erro ao excluir recebivel", error: e, stackTrace: s);
      throw RepositoryException(
          message: e.response?.data['error'] ?? 'Error ao excluir recebivel');
    }
  }
}
