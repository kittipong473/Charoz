import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SubNotiModel {
  final String userid;
  final String type;
  final String name;
  final String detail;
  final String image;
  final Timestamp start;
  final Timestamp end;
  final int status;
  SubNotiModel({
    required this.userid,
    required this.type,
    required this.name,
    required this.detail,
    required this.image,
    required this.start,
    required this.end,
    required this.status,
  });

  SubNotiModel copyWith({
    String? userid,
    String? type,
    String? name,
    String? detail,
    String? image,
    Timestamp? start,
    Timestamp? end,
    int? status,
  }) {
    return SubNotiModel(
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
      'userid': userid,
      'type': type,
      'name': name,
      'detail': detail,
      'image': image,
      'start': start,
      'end': end,
      'status': status,
    };
  }

  factory SubNotiModel.fromMap(Map<String, dynamic> map) {
    return SubNotiModel(
      userid: map['userid'] ?? '',
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      detail: map['detail'] ?? '',
      image: map['image'] ?? '',
      start: map['start'],
      end: map['end'],
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubNotiModel.fromJson(String source) => SubNotiModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubNotiModel(userid: $userid, type: $type, name: $name, detail: $detail, image: $image, start: $start, end: $end, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SubNotiModel &&
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
    return userid.hashCode ^
      type.hashCode ^
      name.hashCode ^
      detail.hashCode ^
      image.hashCode ^
      start.hashCode ^
      end.hashCode ^
      status.hashCode;
  }
}
