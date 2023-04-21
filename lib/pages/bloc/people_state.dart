part of 'people_bloc.dart';

@immutable
class PeopleState extends Equatable {
  List<PeopleModel> allPeople;
  String messageError;

  PeopleState({this.allPeople = const <PeopleModel>[], this.messageError = ''});

  @override
  List<Object> get props => [allPeople, messageError];
}
