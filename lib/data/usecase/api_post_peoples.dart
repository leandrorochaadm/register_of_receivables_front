import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/models/people_model.dart';
import '../../domain/usecases/usecases.dart';

class ApiPostPeoples implements PostPeople {
  final CustomDio dio;

  ApiPostPeoples({required this.dio});

  @override
  Future<bool> createPeople(PeopleModel people) async {
    try {
      await dio.post('/users', data: people.toJson());
      return true;
    } on DioError catch (e, s) {
      log("Erro ao criar pessoa", error: e, stackTrace: s);
      print('....>>>>');
      print(e.response?.data['error']);
      throw RepositoryException(
          message: e.response?.data['error'] ?? 'Error ao registrar pessoa');
      return false;
    }
  }
}
