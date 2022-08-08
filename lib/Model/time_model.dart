// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeModel {
  final String id;
  final String shopid;
  final String open;
  final String close;
  final String status;
  final String choose;
  TimeModel({
    required this.id,
    required this.shopid,
    required this.open,
    required this.close,
    required this.status,
    required this.choose,
  });

  TimeModel copyWith({
    String? id,
    String? shopid,
    String? open,
    String? close,
    String? status,
    String? choose,
  }) {
    return TimeModel(
      id: id ?? this.id,
      shopid: shopid ?? this.shopid,
      open: open ?? this.open,
      close: close ?? this.close,
      status: status ?? this.status,
      choose: choose ?? this.choose,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopid': shopid,
      'open': open,
      'close': close,
      'status': status,
      'choose': choose,
    };
  }

  factory TimeModel.fromMap(Map<String, dynamic> map) {
    return TimeModel(
      id: map['id'] ?? '',
      shopid: map['shopid'] ?? '',
      open: map['open'] ?? '',
      close: map['close'] ?? '',
      status: map['status'] ?? '',
      choose: map['choose'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeModel.fromJson(String source) => TimeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TimeModel(id: $id, shopid: $shopid, open: $open, close: $close, status: $status, choose: $choose)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TimeModel &&
      other.id == id &&
      other.shopid == shopid &&
      other.open == open &&
      other.close == close &&
      other.status == status &&
      other.choose == choose;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      shopid.hashCode ^
      open.hashCode ^
      close.hashCode ^
      status.hashCode ^
      choose.hashCode;
  }
}

TimeModel convertTime(dynamic item) {
  return TimeModel(
    id: item.id,
    shopid: item['shopid'],
    open: item['open'],
    close: item['close'],
    status: item['status'],
    choose: item['choose'],
  );
}
