import 'package:dio/dio.dart';
import 'package:register_of_receivables_front/data/models/people_model.dart';

class GetPeople {
  Future<List<PeopleModel>> call() async {
    try {
      final response = await Dio().get('http://localhost:5000/users');
      var list = <PeopleModel>[];
      for (final people in response.data as List) {
        list.add(PeopleModel.fromJson(people));
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
