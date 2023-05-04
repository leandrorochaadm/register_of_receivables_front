import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/models/people_model.dart';
import '../../domain/usecases/usecases.dart';

class ApiPutPeoples implements PutPeople {
  final CustomDio dio;

  ApiPutPeoples({required this.dio});

  @override
  Future<void> updatePeople(PeopleModel people) async {
    try {
      await dio.put('/users/${people.id}', data: people.toJson());
    } on DioError catch (e, s) {
      log("Erro ao atualizar pessoa", error: e, stackTrace: s);
      throw RepositoryException(
          message: e.response?.data['error'] ?? 'Error ao atualizar pessoa');
    }
  }
}
