import 'package:equatable/equatable.dart';

import 'people_simplify_model.dart';

class PeopleModel extends Equatable {
  const PeopleModel({
    required this.id,
    required this.name,
    required this.nick,
    required this.cnpj,
    required this.ie,
    required this.isClient,
    required this.isSeller,
    required this.phone1,
    required this.phone2,
    required this.phone3,
    required this.address,
    required this.email,
    required this.obs,
    required this.seller,
    this.isActive = 1,
  });

  final int id;
  final String name;
  final String nick;
  final String cnpj;
  final String ie;
  final int isClient;
  final int isSeller;
  final String phone1;
  final String phone2;
  final String phone3;
  final String address;
  final String email;
  final String obs;
  final PeopleSimplify seller;
  final int isActive;

  factory PeopleModel.empty() => const PeopleModel(
        id: 0,
        name: 'Selecione',
        nick: 'Pessoa/Empresa',
        cnpj: '',
        ie: '',
        isClient: 0,
        isSeller: 0,
        phone1: '',
        phone2: '',
        phone3: '',
        address: '',
        email: '',
        obs: '',
        isActive: 1,
        seller: PeopleSimplify(
          id: 0,
          name: 'Selecione',
          nick: 'Pessoa/Empresa',
        ),
      );

  factory PeopleModel.news() => PeopleModel(
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
      email: '',
      obs: '',
      isActive: 1,
      seller: PeopleSimplify.empty());

  PeopleModel copyWith({
    int? id,
    String? name,
    String? nick,
    String? cnpj,
    String? ie,
    int? isClient,
    int? isSeller,
    String? phone1,
    String? phone2,
    String? phone3,
    String? address,
    String? email,
    String? obs,
    PeopleSimplify? seller,
    int? isActive,
  }) =>
      PeopleModel(
        id: id ?? this.id,
        name: name ?? this.name,
        nick: nick ?? this.nick,
        cnpj: cnpj ?? this.cnpj,
        ie: ie ?? this.ie,
        isClient: isClient ?? this.isClient,
        isSeller: isSeller ?? this.isSeller,
        phone1: phone1 ?? this.phone1,
        phone2: phone2 ?? this.phone2,
        phone3: phone3 ?? this.phone3,
        address: address ?? this.address,
        email: email ?? this.email,
        obs: obs ?? this.obs,
        seller: seller ?? this.seller,
        isActive: isActive ?? this.isActive,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['nick'] = nick;
    map['cnpj'] = cnpj;
    map['ie'] = ie;
    map['is_client'] = isClient;
    map['is_seller'] = isSeller;
    map['phone1'] = phone1;
    map['phone2'] = phone2;
    map['phone3'] = phone3;
    map['address'] = address;
    map['email'] = email;
    map['obs'] = obs;
    map['seller'] = seller;
    map['is_active'] = isActive;
    return map;
  }

  factory PeopleModel.fromJson(dynamic json) {
    var seller = PeopleSimplify.fromJson(json['seller']);
    return PeopleModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nick: json['nick'] ?? '',
      cnpj: json['cnpj'] ?? '',
      ie: json['ie'] ?? '',
      isClient: json['is_client'] ?? 0,
      isSeller: json['is_seller'] ?? 0,
      phone1: json['phone1'] ?? '',
      phone2: json['phone2'] ?? '',
      phone3: json['phone3'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      obs: json['obs'] ?? '',
      seller: seller,
      isActive: json['is_active'] ?? 0,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        nick,
        cnpj,
        ie,
        isClient,
        isSeller,
        phone1,
        phone2,
        phone3,
        address,
        email,
        obs,
        seller,
        isActive,
      ];

  @override
  String toString() {
    return "$name ($nick)";
  }

  toPeopleSimplify() => PeopleSimplify(id: id, name: name, nick: nick);
}
