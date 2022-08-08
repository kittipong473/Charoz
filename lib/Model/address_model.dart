// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String id;
  final String userid;
  final String name;
  final String detail;
  final int lat;
  final int lng;
  final DateTime time;
  AddressModel({
    required this.id,
    required this.userid,
    required this.name,
    required this.detail,
    required this.lat,
    required this.lng,
    required this.time,
  });

  AddressModel copyWith({
    String? id,
    String? userid,
    String? name,
    String? detail,
    int? lat,
    int? lng,
    DateTime? time,
  }) {
    return AddressModel(
      id: id ?? this.id,
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
      'id': id,
      'userid': userid,
      'name': name,
      'detail': detail,
      'lat': lat,
      'lng': lng,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? '',
      userid: map['userid'] ?? '',
      name: map['name'] ?? '',
      detail: map['detail'] ?? '',
      lat: map['lat']?.toInt() ?? 0,
      lng: map['lng']?.toInt() ?? 0,
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(id: $id, userid: $userid, name: $name, detail: $detail, lat: $lat, lng: $lng, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddressModel &&
      other.id == id &&
      other.userid == userid &&
      other.name == name &&
      other.detail == detail &&
      other.lat == lat &&
      other.lng == lng &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userid.hashCode ^
      name.hashCode ^
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
    name: item['name'],
    detail: item['detail'],
    lat: item['lat'],
    lng: item['lng'],
    time: (item['time'] as Timestamp).toDate(),
  );
}
