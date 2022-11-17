import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotiManage {
  final String type;
  final String name;
  final String detail;
  final String image;
  final int receive;
  final int status;
  final Timestamp time;
  NotiManage({
    required this.type,
    required this.name,
    required this.detail,
    required this.image,
    required this.receive,
    required this.status,
    required this.time,
  });

  NotiManage copyWith({
    String? type,
    String? name,
    String? detail,
    String? image,
    int? receive,
    int? status,
    Timestamp? time,
  }) {
    return NotiManage(
      type: type ?? this.type,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      image: image ?? this.image,
      receive: receive ?? this.receive,
      status: status ?? this.status,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'detail': detail,
      'image': image,
      'receive': receive,
      'status': status,
      'time': time,
    };
  }

  factory NotiManage.fromMap(Map<String, dynamic> map) {
    return NotiManage(
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      detail: map['detail'] ?? '',
      image: map['image'] ?? '',
      receive: map['receive']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiManage.fromJson(String source) =>
      NotiManage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotiManage(type: $type, name: $name, detail: $detail, image: $image, receive: $receive, status: $status, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotiManage &&
        other.type == type &&
        other.name == name &&
        other.detail == detail &&
        other.image == image &&
        other.receive == receive &&
        other.status == status &&
        other.time == time;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        name.hashCode ^
        detail.hashCode ^
        image.hashCode ^
        receive.hashCode ^
        status.hashCode ^
        time.hashCode;
  }
}
