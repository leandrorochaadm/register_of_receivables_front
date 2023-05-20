import '../../data/models/models.dart';

abstract class GetVisitedClients {
  Future<List<VisitedClientModel>> findAll();
}
