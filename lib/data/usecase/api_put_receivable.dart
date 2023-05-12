import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/models/receivable_model.dart';
import '../../domain/usecases/usecases.dart';
import '../models/models.dart';

class ApiPutReceivables implements PutReceivable {
  final CustomDio dio;

  ApiPutReceivables({required this.dio});

  @override
  Future<void> updateReceivable(ReceivableModel receivable) async {
    try {
      await dio.put('/receivable/${receivable.id}', data: receivable.toJson());
    } on DioError catch (e, s) {
      log("Erro ao atualizar recebivel", error: e, stackTrace: s);
      throw RepositoryException(
          message: e.response?.data['error'] ?? 'Error ao atualizar recebivel');
    }
  }
}
