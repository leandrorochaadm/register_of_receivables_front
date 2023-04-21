part of 'people_bloc.dart';

@immutable
class PeopleState extends Equatable {
  List<PeopleModel> allPeople;

  PeopleState({this.allPeople = const <PeopleModel>[]});

  @override
  List<Object> get props => [allPeople];
}
