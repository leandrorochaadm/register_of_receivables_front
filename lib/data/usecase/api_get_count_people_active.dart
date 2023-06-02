import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';

class ApiGetCountPeopleActive implements GetCountPeopleActive {
  final CustomDio dio;

  ApiGetCountPeopleActive({required this.dio});

  @override
  Future<int> countPeopleActive() async {
    try {
      final response = await dio.get('/countUserActive');
      return response.data;
    } on DioError catch (e, s) {
      log("Erro ao buscar quantidade de cliente ativos",
          error: e, stackTrace: s);
      throw RepositoryException(
          message: "Erro ao buscar quantidade de cliente ativos");
    }
  }
}
