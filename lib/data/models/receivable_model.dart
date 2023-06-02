import 'package:equatable/equatable.dart';
import 'package:register_of_receivables_front/data/models/models.dart';

class ReceivableModel extends Equatable {
  final int id;
  final FormOfPaymentModel formOfPayment;
  final DateTime dateEntry;
  final DateTime dateDue;
  final DateTime? dateReceiving;
  final PeopleSimplify client;
  final String numDoc;
  final double value;
  final String destiny;
  final PeopleSimplify seller;

  const ReceivableModel({
    required this.id,
    required this.formOfPayment,
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
        client = PeopleSimplify.empty(),
        dateDue = DateTime.now(),
        dateEntry = DateTime.now(),
        dateReceiving = null,
        destiny = '',
        numDoc = '',
        seller = PeopleSimplify.empty(),
        formOfPayment = FormOfPaymentModel.empty();

  @override
  List<Object> get props => [
        id,
        formOfPayment,
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
      'formOfPayment': formOfPayment.name,
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
    var client = PeopleSimplify.fromJson(map['client']);
    var seller = PeopleSimplify.fromJson(map['seller']);
    var formOfPayment = FormOfPaymentModel.fromJson(map['formOfPayment']);

    return ReceivableModel(
      id: map['id'] as int,
      formOfPayment: formOfPayment,
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

  ReceivableModel copyWith({
    int? id,
    FormOfPaymentModel? formOfPayment,
    DateTime? dateEntry,
    DateTime? dateDue,
    DateTime? dateReceiving,
    PeopleSimplify? client,
    String? numDoc,
    double? value,
    String? destiny,
    PeopleSimplify? seller,
  }) {
    return ReceivableModel(
      id: id ?? this.id,
      formOfPayment: formOfPayment ?? this.formOfPayment,
      dateEntry: dateEntry ?? this.dateEntry,
      dateDue: dateDue ?? this.dateDue,
      dateReceiving: dateReceiving ?? this.dateReceiving,
      client: client ?? this.client,
      numDoc: numDoc ?? this.numDoc,
      value: value ?? this.value,
      destiny: destiny ?? this.destiny,
      seller: seller ?? this.seller,
    );
  }
}
