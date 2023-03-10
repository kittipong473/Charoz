// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String? id;
  String? userid;
  int? type;
  String? detail;
  double? lat;
  double? lng;
  DateTime? time;
  AddressModel({
    this.id,
    this.userid,
    this.type,
    this.detail,
    this.lat,
    this.lng,
    this.time,
  });

  AddressModel copyWith({
    String? id,
    String? userid,
    int? type,
    String? detail,
    double? lat,
    double? lng,
    DateTime? time,
  }) {
    return AddressModel(
      id: id ?? this.id,
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
      'id': id,
      'userid': userid,
      'type': type,
      'detail': detail,
      'lat': lat,
      'lng': lng,
      'time': time,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] != null ? map['id'] as String : null,
      userid: map['userid'] != null ? map['userid'] as String : null,
      type: map['type'] != null ? map['type'] as int : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      lng: map['lng'] != null ? map['lng'] as double : null,
      time: map['time'] != null ? (map['time'] as Timestamp).toDate() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(id: $id, userid: $userid, type: $type, detail: $detail, lat: $lat, lng: $lng, time: $time)';
  }

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userid == userid &&
        other.type == type &&
        other.detail == detail &&
        other.lat == lat &&
        other.lng == lng &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userid.hashCode ^
        type.hashCode ^
        detail.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        time.hashCode;
  }
}

AddressModel convertAddress(dynamic item, String? id) {
  return AddressModel(
    id: id ?? item.id,
    userid: item['userid'],
    type: item['type'],
    detail: item['detail'],
    lat: item['lat'],
    lng: item['lng'],
    time: (item['time'] as Timestamp).toDate(),
  );
}
