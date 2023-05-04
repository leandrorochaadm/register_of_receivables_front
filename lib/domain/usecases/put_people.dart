import 'package:register_of_receivables_front/data/models/models.dart';

abstract class PutPeople {
  Future<bool> updatePeople(PeopleModel people);
}
