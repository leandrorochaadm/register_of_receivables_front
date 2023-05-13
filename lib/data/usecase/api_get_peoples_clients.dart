import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../data/models/people_model.dart';
import '../../domain/usecases/usecases.dart';

class ApiGetPeoplesClients implements GetPeoplesClients {
  final CustomDio dio;

  ApiGetPeoplesClients({required this.dio});

  @override
  Future<List<PeopleModel>> findAllPeoplesClients() async {
    try {
      final response = await dio.get('/users/clients');
      var list = <PeopleModel>[];
      for (final people in response.data as List) {
        list.add(PeopleModel.fromJson(people));
      }
      return list;
    } on DioError catch (e, s) {
      log("Erro ao buscar clientes", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao buscar clientes");
    }
  }
}
