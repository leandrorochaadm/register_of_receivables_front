import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/models/receivable_model.dart';
import '../../domain/usecases/usecases.dart';
import '../models/models.dart';

class ApiPostReceivables implements PostReceivable {
  final CustomDio dio;

  ApiPostReceivables({required this.dio});

  @override
  Future<void> createReceivable(ReceivableModel receivable) async {
    try {
      await dio.post('/receivables', data: receivable.toJson());
    } on DioError catch (e, s) {
      log("Erro ao criar recebevel", error: e, stackTrace: s);
      throw RepositoryException(
          message: e.response?.data['error'] ?? 'Error ao registrar recebevel');
    }
  }
}
