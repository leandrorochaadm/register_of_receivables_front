import 'package:register_of_receivables_front/data/models/models.dart';

abstract class GetPeople {
  Future<List<PeopleModel>> findAllPeoples({
    required String name,
    required String isActive,
  });
}
