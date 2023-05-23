import 'package:equatable/equatable.dart';

class PeopleSimplify extends Equatable {
  final int id;
  final String name;
  final String nick;

  const PeopleSimplify({
    required this.id,
    required this.name,
    required this.nick,
  });

  factory PeopleSimplify.empty() => const PeopleSimplify(
        id: 0,
        name: 'Selecione',
        nick: 'Pessoa/Empresa',
      );

  @override
  List<Object?> get props => [id, name, nick];
}
