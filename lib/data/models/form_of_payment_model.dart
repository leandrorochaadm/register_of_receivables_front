import 'package:equatable/equatable.dart';

class FormOfPaymentModel extends Equatable {
  final int id;
  final String name;

  const FormOfPaymentModel({required this.id, required this.name});

  factory FormOfPaymentModel.empty() =>
      const FormOfPaymentModel(id: 0, name: 'Selecione');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory FormOfPaymentModel.fromJson(dynamic map) {
    if (map != null) {
      return FormOfPaymentModel(
        id: map['id'] as int,
        name: map['name'] as String,
      );
    }
    return FormOfPaymentModel.empty();
  }

  @override
  List<Object> get props => [id, name];
}
