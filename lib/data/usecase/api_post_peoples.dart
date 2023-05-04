import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/models/people_model.dart';
import '../../domain/usecases/usecases.dart';

class ApiPostPeoples implements PostPeople {
  final CustomDio dio;

  ApiPostPeoples({required this.dio});

  @override
  Future<void> createPeople(PeopleModel people) async {
    try {
      await dio.post('/users', data: people.toJson());
    } on DioError catch (e, s) {
      log("Erro ao criar pessoa", error: e, stackTrace: s);
      throw RepositoryException(
          message: e.response?.data['error'] ?? 'Error ao registrar pessoa');
    }
  }
}
