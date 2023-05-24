import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/models/people_model.dart';
import '../../domain/usecases/usecases.dart';

class ApiGetPeoples implements GetPeople {
  final CustomDio dio;

  ApiGetPeoples({required this.dio});

  @override
  Future<List<PeopleModel>> findAllPeoples(String name) async {
    try {
      final response = await dio.get('/users?name_or_nick=$name');
      var list = <PeopleModel>[];
      for (final people in response.data as List) {
        list.add(PeopleModel.fromJson(people));
      }
      return list;
    } on DioError catch (e, s) {
      log("Erro ao buscar produtos", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao buscar produtos");
    }
  }
}
