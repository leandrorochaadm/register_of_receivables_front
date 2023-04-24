part of 'people_list_controller.dart';

@match
enum PeopleListStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class PeopleListState extends Equatable {
  final PeopleListStateStatus status;
  final List<PeopleModel> peoples;
  final String? errorMessage;
  final PeopleModel peopleEditing;

  const PeopleListState({
    required this.peoples,
    this.errorMessage,
    required this.status,
    required this.peopleEditing,
  });

  const PeopleListState.initial()
      : status = PeopleListStateStatus.initial,
        peoples = const [],
        errorMessage = null,
        peopleEditing = const PeopleModel(
          id: 0,
          name: '',
          nick: '',
          cnpj: '',
          ie: '',
          isClient: 0,
          isSeller: 0,
          phone1: '',
          phone2: '',
          phone3: '',
          address: '',
          obs: '',
        );

  @override
  List<Object?> get props => [status, peoples, errorMessage, peopleEditing];

  PeopleListState copyWith({
    PeopleListStateStatus? status,
    List<PeopleModel>? peoples,
    String? errorMessage,
    PeopleModel? peopleEditing,
  }) {
    return PeopleListState(
      status: status ?? this.status,
      peoples: peoples ?? this.peoples,
      errorMessage: errorMessage ?? this.errorMessage,
      peopleEditing: peopleEditing ?? this.peopleEditing,
    );
  }
}
