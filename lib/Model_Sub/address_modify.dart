import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModify {
  final String userid;
  final String name;
  final String detail;
  final int lat;
  final int lng;
  final Timestamp time;
  AddressModify({
    required this.userid,
    required this.name,
    required this.detail,
    required this.lat,
    required this.lng,
    required this.time,
  });

  AddressModify copyWith({
    String? userid,
    String? name,
    String? detail,
    int? lat,
    int? lng,
    Timestamp? time,
  }) {
    return AddressModify(
      userid: userid ?? this.userid,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'name': name,
      'detail': detail,
      'lat': lat,
      'lng': lng,
      'time': time,
    };
  }

  factory AddressModify.fromMap(Map<String, dynamic> map) {
    return AddressModify(
      userid: map['userid'] ?? '',
      name: map['name'] ?? '',
      detail: map['detail'] ?? '',
      lat: map['lat']?.toInt() ?? 0,
      lng: map['lng']?.toInt() ?? 0,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModify.fromJson(String source) => AddressModify.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubAddressModel(userid: $userid, name: $name, detail: $detail, lat: $lat, lng: $lng, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddressModify &&
      other.userid == userid &&
      other.name == name &&
      other.detail == detail &&
      other.lat == lat &&
      other.lng == lng &&
      other.time == time;
  }

  @override
  int get hashCode {
    return userid.hashCode ^
      name.hashCode ^
      detail.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      time.hashCode;
  }
}
