import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddressManage {
  final String userid;
  final int type;
  final String detail;
  final int lat;
  final int lng;
  final Timestamp time;
  AddressManage({
    required this.userid,
    required this.type,
    required this.detail,
    required this.lat,
    required this.lng,
    required this.time,
  });

  AddressManage copyWith({
    String? userid,
    int? type,
    String? detail,
    int? lat,
    int? lng,
    Timestamp? time,
  }) {
    return AddressManage(
      userid: userid ?? this.userid,
      type: type ?? this.type,
      detail: detail ?? this.detail,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'type': type,
      'detail': detail,
      'lat': lat,
      'lng': lng,
      'time': time,
    };
  }

  factory AddressManage.fromMap(Map<String, dynamic> map) {
    return AddressManage(
      userid: map['userid'] ?? '',
      type: map['type']?.toInt() ?? 0,
      detail: map['detail'] ?? '',
      lat: map['lat']?.toInt() ?? 0,
      lng: map['lng']?.toInt() ?? 0,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressManage.fromJson(String source) =>
      AddressManage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressManage(userid: $userid, type: $type, detail: $detail, lat: $lat, lng: $lng, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressManage &&
        other.userid == userid &&
        other.type == type &&
        other.detail == detail &&
        other.lat == lat &&
        other.lng == lng &&
        other.time == time;
  }

  @override
  int get hashCode {
    return userid.hashCode ^
        type.hashCode ^
        detail.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        time.hashCode;
  }
}
