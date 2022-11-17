// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotiModel {
  final String id;
  final int type;
  final String name;
  final String detail;
  final String image;
  final int receive;
  final int status;
  final DateTime time;
  NotiModel({
    required this.id,
    required this.type,
    required this.name,
    required this.detail,
    required this.image,
    required this.receive,
    required this.status,
    required this.time,
  });

  NotiModel copyWith({
    String? id,
    int? type,
    String? name,
    String? detail,
    String? image,
    int? receive,
    int? status,
    DateTime? time,
  }) {
    return NotiModel(
      id: id ?? this.id,
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
      'id': id,
      'type': type,
      'name': name,
      'detail': detail,
      'image': image,
      'receive': receive,
      'status': status,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory NotiModel.fromMap(Map<String, dynamic> map) {
    return NotiModel(
      id: map['id'] ?? '',
      type: map['type']?.toInt() ?? 0,
      name: map['name'] ?? '',
      detail: map['detail'] ?? '',
      image: map['image'] ?? '',
      receive: map['receive']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiModel.fromJson(String source) =>
      NotiModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotiModel(id: $id, type: $type, name: $name, detail: $detail, image: $image, receive: $receive, status: $status, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotiModel &&
        other.id == id &&
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
    return id.hashCode ^
        type.hashCode ^
        name.hashCode ^
        detail.hashCode ^
        image.hashCode ^
        receive.hashCode ^
        status.hashCode ^
        time.hashCode;
  }
}

NotiModel convertNoti(dynamic item) {
  return NotiModel(
    id: item.id,
    type: item['type'],
    name: item['name'],
    detail: item['detail'],
    image: item['image'],
    receive: item['receive'],
    status: item['status'],
    time: (item['end'] as Timestamp).toDate(),
  );
}
