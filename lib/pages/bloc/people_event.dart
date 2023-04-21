part of 'people_bloc.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();
}

class GetPeoplesEvent extends PeopleEvent {
  final List<PeopleModel> allPeople;

  const GetPeoplesEvent({required this.allPeople});

  @override
  List<Object?> get props => [allPeople];
}
