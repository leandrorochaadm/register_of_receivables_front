import 'package:register_of_receivables_front/data/models/models.dart';

abstract class PostPeople {
  Future<void> createPeople(PeopleModel people);
}
