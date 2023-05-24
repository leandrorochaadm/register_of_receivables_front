import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';
import '../models/models.dart';

class ApiGetPeoplesSellers implements GetPeoplesSellers {
  final CustomDio dio;

  ApiGetPeoplesSellers({required this.dio});

  @override
  Future<List<PeopleSimplify>> findAllPeoplesSellers() async {
    try {
      final response = await dio.get('/users/sellers');
      var list = <PeopleSimplify>[];
      for (final people in response.data as List) {
        list.add(PeopleSimplify.fromJson(people));
      }
      return list;
    } on DioError catch (e, s) {
      log("Erro ao buscar vendedores", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao buscar vendedores");
    }
  }
}
