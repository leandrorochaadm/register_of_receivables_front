import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/models/people_model.dart';
import '../../domain/usecases/usecases.dart';

class ApiGetPeoples implements GetPeople {
  final CustomDio dio;

  ApiGetPeoples({required this.dio});

  @override
  Future<List<PeopleModel>> findAllPeoples({
    required String name,
    required String isActive,
  }) async {
    try {
      final response =
          await dio.get('/users?name_or_nick=$name&is_active=$isActive');
      var list = <PeopleModel>[];
      final List listData = response.data ?? [];
      for (final people in listData) {
        list.add(PeopleModel.fromJson(people));
      }
      return list;
    } on DioError catch (e, s) {
      log("Erro ao buscar produtos", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao buscar produtos");
    }
  }
}
