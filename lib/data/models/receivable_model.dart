import 'package:equatable/equatable.dart';

class ReceivableModel extends Equatable {
  final int id;
  final TypeReceivable type;
  final DateTime dateEntry;
  final DateTime dateDue;
  final DateTime dateReceiving;
  final String client;
  final String numDoc;
  final double value;
  final String destiny;
  final String seller;

  const ReceivableModel({
    required this.id,
    required this.type,
    required this.dateEntry,
    required this.dateDue,
    required this.dateReceiving,
    required this.client,
    required this.numDoc,
    required this.value,
    required this.destiny,
    required this.seller,
  });

  ReceivableModel.empty()
      : id = 0,
        value = 0,
        client = '',
        dateDue = DateTime.now(),
        dateEntry = DateTime.now(),
        dateReceiving = DateTime.now(),
        destiny = '',
        numDoc = '',
        seller = '',
        type = TypeReceivable.Boleto;

  @override
  List<Object> get props => [
        id,
        type,
        dateEntry,
        dateDue,
        dateReceiving,
        client,
        numDoc,
        value,
        destiny,
        seller,
      ];
}

enum TypeReceivable {
  Boleto,
  Cheque,
  Promissoria,
}
