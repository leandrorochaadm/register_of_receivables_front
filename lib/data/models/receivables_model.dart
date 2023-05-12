import 'package:equatable/equatable.dart';

import 'models.dart';

class ReceivablesModel extends Equatable {
  List<ReceivableModel> receivables;
  double sum;

  ReceivablesModel({required this.receivables, required this.sum});

  Map<String, dynamic> toJson() {
    return {
      'receivables': receivables,
      'sum': sum,
    };
  }

  factory ReceivablesModel.fromJson(dynamic map) {
    List<ReceivableModel> receivables = [];

    for (var receivable in map['receivables'] as List) {
      receivables.add(ReceivableModel.fromJson(receivable));
    }

    return ReceivablesModel(
      receivables: receivables,
      sum: map['sum'] as double,
    );
  }

  ReceivablesModel copyWith({
    List<ReceivableModel>? receivables,
    double? sum,
  }) {
    return ReceivablesModel(
      receivables: receivables ?? this.receivables,
      sum: sum ?? this.sum,
    );
  }

  @override
  List<Object> get props => [receivables, sum];
}
