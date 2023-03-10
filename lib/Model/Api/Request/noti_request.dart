
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotiRequest {
  int? type;
  String? name;
  String? detail;
  int? receive;
  bool? status;
  Timestamp? time;
  NotiRequest({
    this.type,
    this.name,
    this.detail,
    this.receive,
    this.status,
    this.time,
  });

  NotiRequest copyWith({
    int? type,
    String? name,
    String? detail,
    int? receive,
    bool? status,
    Timestamp? time,
  }) {
    return NotiRequest(
      type: type ?? this.type,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      receive: receive ?? this.receive,
      status: status ?? this.status,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'detail': detail,
      'receive': receive,
      'status': status,
      'time': time,
    };
  }

  factory NotiRequest.fromMap(Map<String, dynamic> map) {
    return NotiRequest(
      type: map['type'] != null ? map['type'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      receive: map['receive'] != null ? map['receive'] as int : null,
      status: map['status'] != null ? map['status'] as bool : null,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiRequest.fromJson(String source) =>
      NotiRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotiManage(type: $type, name: $name, detail: $detail, receive: $receive, status: $status, time: $time)';
  }

  @override
  bool operator ==(covariant NotiRequest other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.name == name &&
        other.detail == detail &&
        other.receive == receive &&
        other.status == status &&
        other.time == time;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        name.hashCode ^
        detail.hashCode ^
        receive.hashCode ^
        status.hashCode ^
        time.hashCode;
  }
}
