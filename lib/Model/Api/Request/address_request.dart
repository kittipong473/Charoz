
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddressRequest {
  String? userid;
  int? type;
  String? detail;
  double? lat;
  double? lng;
  Timestamp? time;
  AddressRequest({
    this.userid,
    this.type,
    this.detail,
    this.lat,
    this.lng,
    this.time,
  });

  AddressRequest copyWith({
    String? userid,
    int? type,
    String? detail,
    double? lat,
    double? lng,
    Timestamp? time,
  }) {
    return AddressRequest(
      userid: userid ?? this.userid,
      type: type ?? this.type,
      detail: detail ?? this.detail,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'type': type,
      'detail': detail,
      'lat': lat,
      'lng': lng,
      'time': time,
    };
  }

  factory AddressRequest.fromMap(Map<String, dynamic> map) {
    return AddressRequest(
      userid: map['userid'] != null ? map['userid'] as String : null,
      type: map['type'] != null ? map['type'] as int : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      lng: map['lng'] != null ? map['lng'] as double : null,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressRequest.fromJson(String source) =>
      AddressRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressRequest(userid: $userid, type: $type, detail: $detail, lat: $lat, lng: $lng, time: $time)';
  }

  @override
  bool operator ==(covariant AddressRequest other) {
    if (identical(this, other)) return true;

    return other.userid == userid &&
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
