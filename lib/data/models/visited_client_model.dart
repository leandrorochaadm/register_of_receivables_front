class VisitedClientModel {
  num? dateEntry;
  num? clientId;
  String? clientName;
  String? clientNick;
  num? sellerId;
  String? sellerName;
  String? sellerNick;

  VisitedClientModel({
    this.dateEntry,
    this.clientId,
    this.clientName,
    this.clientNick,
    this.sellerId,
    this.sellerName,
    this.sellerNick,
  });

  VisitedClientModel.fromJson(dynamic json) {
    dateEntry = json['dateEntry'];
    clientId = json['clientId'];
    clientName = json['clientName'];
    clientNick = json['clientNick'];
    sellerId = json['sellerId'];
    sellerName = json['sellerName'];
    sellerNick = json['sellerNick'];
  }

  VisitedClientModel copyWith({
    num? dateEntry,
    num? clientId,
    String? clientName,
    String? clientNick,
    num? sellerId,
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
}
