// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotiOrderModel {
  final int notiorderId;
  final int orderId;
  final String notiorderName;
  final String notiorderStatus;
  final DateTime created;
  final DateTime updated;
  NotiOrderModel({
    required this.notiorderId,
    required this.orderId,
    required this.notiorderName,
    required this.notiorderStatus,
    required this.created,
    required this.updated,
  });

  NotiOrderModel copyWith({
    int? notiorderId,
    int? orderId,
    String? notiorderName,
    String? notiorderStatus,
    DateTime? created,
    DateTime? updated,
  }) {
    return NotiOrderModel(
      notiorderId: notiorderId ?? this.notiorderId,
      orderId: orderId ?? this.orderId,
      notiorderName: notiorderName ?? this.notiorderName,
      notiorderStatus: notiorderStatus ?? this.notiorderStatus,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notiorderId': notiorderId,
      'orderId': orderId,
      'notiorderName': notiorderName,
      'notiorderStatus': notiorderStatus,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory NotiOrderModel.fromMap(Map<String, dynamic> map) {
    return NotiOrderModel(
      notiorderId: map['notiorderId']?.toInt() ?? 0,
      orderId: map['orderId']?.toInt() ?? 0,
      notiorderName: map['notiorderName'] ?? '',
      notiorderStatus: map['notiorderStatus'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiOrderModel.fromJson(String source) => NotiOrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotiOrderModel(notiorderId: $notiorderId, orderId: $orderId, notiorderName: $notiorderName, notiorderStatus: $notiorderStatus, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NotiOrderModel &&
      other.notiorderId == notiorderId &&
      other.orderId == orderId &&
      other.notiorderName == notiorderName &&
      other.notiorderStatus == notiorderStatus &&
      other.created == created &&
      other.updated == updated;
  }

  @override
  int get hashCode {
    return notiorderId.hashCode ^
      orderId.hashCode ^
      notiorderName.hashCode ^
      notiorderStatus.hashCode ^
      created.hashCode ^
      updated.hashCode;
  }
}
