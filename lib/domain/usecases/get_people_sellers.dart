import 'package:register_of_receivables_front/data/models/models.dart';

abstract class GetPeoplesSellers {
  Future<List<PeopleModel>> findAllPeoplesSellers();
}
