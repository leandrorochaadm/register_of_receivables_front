part of 'people_bloc.dart';

abstract class PeopleEvent {
  const PeopleEvent();
}

class GetPeoplesEvent extends PeopleEvent {
  const GetPeoplesEvent();
}
