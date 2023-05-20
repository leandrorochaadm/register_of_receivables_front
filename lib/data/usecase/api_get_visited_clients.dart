import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../domain/usecases/usecases.dart';
import '../models/models.dart';

class ApiGetVisitedClients implements GetVisitedClients {
  final CustomDio dio;

  ApiGetVisitedClients({required this.dio});

  @override
  Future<List<VisitedClientModel>> findAll() async {
    try {
      final response = await dio.get('/visitedClients');
      var list = <VisitedClientModel>[];
      for (final VisitedClient in response.data as List) {
        list.add(VisitedClientModel.fromJson(VisitedClient));
      }
      return list;
    } on DioError catch (e, s) {
      log("Erro ao buscar clientes visitados", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao buscar clientes visitados");
    }
  }
}
