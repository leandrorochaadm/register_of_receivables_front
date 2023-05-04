import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';

class ApiDeletePeoples implements DeletePeople {
  final CustomDio dio;

  ApiDeletePeoples({required this.dio});

  @override
  Future<void> deletePeople(String id) async {
    try {
      await dio.delete('/users/$id');
    } on DioError catch (e, s) {
      log("Erro ao excluir pessoa", error: e, stackTrace: s);
      throw RepositoryException(
          message: e.response?.data['error'] ?? 'Error ao excluir pessoa');
    }
  }
}
