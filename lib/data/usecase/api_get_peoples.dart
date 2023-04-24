import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:register_of_receivables_front/core/core.dart';
import 'package:register_of_receivables_front/data/models/people_model.dart';

class ApiGetPeoples {
  final CustomDio dio;

  ApiGetPeoples({required this.dio});

  Future<List<PeopleModel>> call() async {
    try {
      final response = await dio.get('/users');
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