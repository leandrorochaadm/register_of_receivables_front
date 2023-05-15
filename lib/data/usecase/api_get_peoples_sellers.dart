import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/models/people_model.dart';
import '../../domain/usecases/usecases.dart';

class ApiGetPeoplesSellers implements GetPeoplesSellers {
  final CustomDio dio;

  ApiGetPeoplesSellers({required this.dio});

  @override
  Future<List<PeopleModel>> findAllPeoplesSellers() async {
    try {
      final response = await dio.get('/users/sellers');
      var list = <PeopleModel>[];
      for (final people in response.data as List) {
        list.add(PeopleModel.fromJson(people));
      }
      return list;
    } on DioError catch (e, s) {
      log("Erro ao buscar vendedores", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao buscar vendedores");
    }
  }
}
