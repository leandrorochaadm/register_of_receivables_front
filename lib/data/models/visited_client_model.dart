import 'package:equatable/equatable.dart';

class VisitedClientModel extends Equatable {
  final int dateEntry;
  final int clientId;
  final String clientName;
  final String clientNick;
  final int sellerId;
  final String sellerName;
  final String sellerNick;

  const VisitedClientModel({
    required this.dateEntry,
    required this.clientId,
    required this.clientName,
    required this.clientNick,
    required this.sellerId,
    required this.sellerName,
    required this.sellerNick,
  });

  factory VisitedClientModel.fromJson(dynamic json) => VisitedClientModel(
        dateEntry: json['dateEntry'],
        clientId: json['clientId'],
        clientName: json['clientName'],
        clientNick: json['clientNick'],
        sellerId: json['sellerId'],
        sellerName: json['sellerName'],
        sellerNick: json['sellerNick'],
      );

  VisitedClientModel copyWith({
    int? dateEntry,
    int? clientId,
    String? clientName,
    String? clientNick,
    int? sellerId,
    String? sellerName,
    String? sellerNick,
  }) =>
      VisitedClientModel(
        dateEntry: dateEntry ?? this.dateEntry,
        clientId: clientId ?? this.clientId,
        clientName: clientName ?? this.clientName,
        clientNick: clientNick ?? this.clientNick,
        sellerId: sellerId ?? this.sellerId,
        sellerName: sellerName ?? this.sellerName,
        sellerNick: sellerNick ?? this.sellerNick,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dateEntry'] = dateEntry;
    map['clientId'] = clientId;
    map['clientName'] = clientName;
    map['clientNick'] = clientNick;
    map['sellerId'] = sellerId;
    map['sellerName'] = sellerName;
    map['sellerNick'] = sellerNick;
    return map;
  }

  @override
  List<Object?> get props => [dateEntry, clientId, sellerId];
}
