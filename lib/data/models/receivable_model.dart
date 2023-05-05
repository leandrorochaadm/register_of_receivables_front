import 'package:equatable/equatable.dart';

class ReceivableModel extends Equatable {
  final DateTime dateEntry;
  final DateTime dateDue;
  final String client;
  final String numDoc;
  final double value;
  final String destiny;
  final String seller;

  const ReceivableModel({
    required this.dateEntry,
    required this.dateDue,
    required this.client,
    required this.numDoc,
    required this.value,
    required this.destiny,
    required this.seller,
  });

  ReceivableModel.initial()
      : value = 0,
        client = '',
        dateDue = DateTime.now(),
        dateEntry = DateTime.now(),
        destiny = '',
        numDoc = '',
        seller = '';

  @override
  List<Object> get props => [
        dateEntry,
        dateDue,
        client,
        numDoc,
        value,
        destiny,
        seller,
      ];
}
