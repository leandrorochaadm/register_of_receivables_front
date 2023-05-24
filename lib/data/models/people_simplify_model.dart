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

  factory PeopleSimplify.fromJson(dynamic json) => PeopleSimplify(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        nick: json['nick'] ?? '',
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['nick'] = nick;
    return map;
  }

  @override
  String toString() {
    return "$name ($nick)";
  }
}
