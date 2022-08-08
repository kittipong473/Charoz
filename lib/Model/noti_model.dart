// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotiModel {
  final String id;
  final String userid;
  final String type;
  final String name;
  final String detail;
  final String image;
  final DateTime start;
  final DateTime end;
  final int status;
  NotiModel({
    required this.id,
    required this.userid,
    required this.type,
    required this.name,
    required this.detail,
    required this.image,
    required this.start,
    required this.end,
    required this.status,
  });

  NotiModel copyWith({
    String? id,
    String? userid,
    String? type,
    String? name,
    String? detail,
    String? image,
    DateTime? start,
    DateTime? end,
    int? status,
  }) {
    return NotiModel(
      id: id ?? this.id,
      userid: userid ?? this.userid,
      type: type ?? this.type,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      image: image ?? this.image,
      start: start ?? this.start,
      end: end ?? this.end,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'type': type,
      'name': name,
      'detail': detail,
      'image': image,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'status': status,
    };
  }

  factory NotiModel.fromMap(Map<String, dynamic> map) {
    return NotiModel(
      id: map['id'] ?? '',
      userid: map['userid'] ?? '',
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      detail: map['detail'] ?? '',
      image: map['image'] ?? '',
      start: DateTime.fromMillisecondsSinceEpoch(map['start']),
      end: DateTime.fromMillisecondsSinceEpoch(map['end']),
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiModel.fromJson(String source) =>
      NotiModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotiModel(id: $id, userid: $userid, type: $type, name: $name, detail: $detail, image: $image, start: $start, end: $end, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotiModel &&
        other.id == id &&
        other.userid == userid &&
        other.type == type &&
        other.name == name &&
        other.detail == detail &&
        other.image == image &&
        other.start == start &&
        other.end == end &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userid.hashCode ^
        type.hashCode ^
        name.hashCode ^
        detail.hashCode ^
        image.hashCode ^
        start.hashCode ^
        end.hashCode ^
        status.hashCode;
  }
}

NotiModel convertNoti(dynamic item) {
  return NotiModel(
    id: item.id,
    userid: item['userid'],
    type: item['type'],
    name: item['name'],
    detail: item['detail'],
    image: item['image'],
    start:(item['start'] as Timestamp).toDate(),
    end: (item['end'] as Timestamp).toDate(),
    status: item['status'],
  );
}
