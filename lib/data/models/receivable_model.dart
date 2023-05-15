import 'package:equatable/equatable.dart';
import 'package:register_of_receivables_front/data/models/models.dart';

class ReceivableModel extends Equatable {
  final int id;
  final TypeReceivable type;
  final DateTime dateEntry;
  final DateTime dateDue;
  final DateTime? dateReceiving;
  final PeopleModel client;
  final String numDoc;
  final double value;
  final String destiny;
  final PeopleModel seller;

  const ReceivableModel({
    required this.id,
    required this.type,
    required this.dateEntry,
    required this.dateDue,
    this.dateReceiving,
    required this.client,
    required this.numDoc,
    required this.value,
    required this.destiny,
    required this.seller,
  });

  ReceivableModel.empty()
      : id = 0,
        value = 0,
        client = PeopleModel.empty(),
        dateDue = DateTime.now(),
        dateEntry = DateTime.now(),
        dateReceiving = null,
        destiny = '',
        numDoc = '',
        seller = PeopleModel.empty(),
        type = TypeReceivable.Boleto;

  @override
  List<Object> get props => [
        id,
        type,
        dateEntry,
        dateDue,
        client,
        numDoc,
        value,
        destiny,
        seller,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'dateEntry': dateEntry.millisecondsSinceEpoch,
      'dateDue': dateDue.millisecondsSinceEpoch,
      'dateReceiving': dateReceiving?.millisecondsSinceEpoch,
      'client': client.toJson(),
      'numDoc': numDoc,
      'value': value,
      'destiny': destiny,
      'seller': seller.toJson(),
    };
  }

  factory ReceivableModel.fromJson(Map<String, dynamic> map) {
    var client = PeopleModel.fromJson(map['client']);
    var seller = PeopleModel.fromJson(map['seller']);

    return ReceivableModel(
      id: map['id'] as int,
      type: map['type'] == TypeReceivable.Boleto.name
          ? TypeReceivable.Boleto
          : TypeReceivable.Cheque,
      dateEntry: DateTime.fromMillisecondsSinceEpoch(map['dateEntry']),
      dateDue: DateTime.fromMillisecondsSinceEpoch(map['dateDue']),
      dateReceiving: map['dateReceiving'] != 0
          ? DateTime.fromMillisecondsSinceEpoch(map['dateReceiving'])
          : null,
      client: client,
      seller: seller,
      numDoc: map['numDoc'] as String,
      value: double.parse(map['value'].toString()),
      destiny: map['destiny'] as String,
    );
  }
}

enum TypeReceivable {
  Boleto,
  Cheque,
  Promissoria,
}
