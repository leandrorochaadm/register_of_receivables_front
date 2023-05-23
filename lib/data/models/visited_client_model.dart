import 'package:equatable/equatable.dart';

class VisitedClientModel extends Equatable {
  final int clientId;
  final String clientName;
  final String clientNick;
  final String clientPhone;
  final int sellerId;
  final String sellerName;
  final String sellerNick;
  final String sellerPhone;

  const VisitedClientModel({
    required this.clientId,
    required this.clientName,
    required this.clientNick,
    required this.clientPhone,
    required this.sellerId,
    required this.sellerName,
    required this.sellerNick,
    required this.sellerPhone,
  });

  factory VisitedClientModel.fromJson(dynamic json) => VisitedClientModel(
        clientId: json['clientId'],
        clientName: json['clientName'],
        clientNick: json['clientNick'],
        clientPhone: json['clientPhone'],
        sellerId: json['sellerId'],
        sellerName: json['sellerName'],
        sellerNick: json['sellerNick'],
        sellerPhone: json['sellerPhone'],
      );

  VisitedClientModel copyWith({
    int? clientId,
    String? clientName,
    String? clientNick,
    String? clientPhone,
    int? sellerId,
    String? sellerName,
    String? sellerNick,
    String? sellerPhone,
  }) =>
      VisitedClientModel(
        clientId: clientId ?? this.clientId,
        clientName: clientName ?? this.clientName,
        clientNick: clientNick ?? this.clientNick,
        clientPhone: clientPhone ?? this.clientPhone,
        sellerId: sellerId ?? this.sellerId,
        sellerName: sellerName ?? this.sellerName,
        sellerNick: sellerNick ?? this.sellerNick,
        sellerPhone: sellerPhone ?? this.sellerPhone,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clientId'] = clientId;
    map['clientName'] = clientName;
    map['clientNick'] = clientNick;
    map['clientPhone'] = clientPhone;
    map['sellerId'] = sellerId;
    map['sellerName'] = sellerName;
    map['sellerNick'] = sellerNick;
    map['sellerPhone'] = sellerPhone;
    return map;
  }

  @override
  List<Object?> get props => [clientId, sellerId];
}
