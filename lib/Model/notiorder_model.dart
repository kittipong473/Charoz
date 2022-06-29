// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotiOrderModel {
  final int notiorderId;
  final int notiorderOrderId;
  final String notiorderName;
  final String notiorderStatus;
  final DateTime created;
  final DateTime updated;
  NotiOrderModel({
    required this.notiorderId,
    required this.notiorderOrderId,
    required this.notiorderName,
    required this.notiorderStatus,
    required this.created,
    required this.updated,
  });

  NotiOrderModel copyWith({
    int? notiorderId,
    int? notiorderOrderId,
    String? notiorderName,
    String? notiorderStatus,
    DateTime? created,
    DateTime? updated,
  }) {
    return NotiOrderModel(
      notiorderId: notiorderId ?? this.notiorderId,
      notiorderOrderId: notiorderOrderId ?? this.notiorderOrderId,
      notiorderName: notiorderName ?? this.notiorderName,
      notiorderStatus: notiorderStatus ?? this.notiorderStatus,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notiorderId': notiorderId,
      'notiorderOrderId': notiorderOrderId,
      'notiorderName': notiorderName,
      'notiorderStatus': notiorderStatus,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory NotiOrderModel.fromMap(Map<String, dynamic> map) {
    return NotiOrderModel(
      notiorderId: map['notiorderId'] as int,
      notiorderOrderId: map['notiorderOrderId'] as int,
      notiorderName: map['notiorderName'] as String,
      notiorderStatus: map['notiorderStatus'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiOrderModel.fromJson(String source) =>
      NotiOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotiOrderModel(notiorderId: $notiorderId, notiorderOrderId: $notiorderOrderId, notiorderName: $notiorderName, notiorderStatus: $notiorderStatus, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotiOrderModel &&
        other.notiorderId == notiorderId &&
        other.notiorderOrderId == notiorderOrderId &&
        other.notiorderName == notiorderName &&
        other.notiorderStatus == notiorderStatus &&
        other.created == created &&
        other.updated == updated;
  }

  @override
  int get hashCode {
    return notiorderId.hashCode ^
        notiorderOrderId.hashCode ^
        notiorderName.hashCode ^
        notiorderStatus.hashCode ^
        created.hashCode ^
        updated.hashCode;
  }
}
