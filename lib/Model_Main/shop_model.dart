// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  final String id;
  final String managerid;
  final String name;
  final String announce;
  final String detail;
  final String address;
  final String phone;
  final double lat;
  final double lng;
  final String image;
  final int freight;
  final int choose;
  final String open;
  final String close;
  final String timetype;
  final DateTime time;
  ShopModel({
    required this.id,
    required this.managerid,
    required this.name,
    required this.announce,
    required this.detail,
    required this.address,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.image,
    required this.freight,
    required this.choose,
    required this.open,
    required this.close,
    required this.timetype,
    required this.time,
  });

  ShopModel copyWith({
    String? id,
    String? managerid,
    String? name,
    String? announce,
    String? detail,
    String? address,
    String? phone,
    double? lat,
    double? lng,
    String? image,
    int? freight,
    int? choose,
    String? open,
    String? close,
    String? timetype,
    DateTime? time,
  }) {
    return ShopModel(
      id: id ?? this.id,
      managerid: managerid ?? this.managerid,
      name: name ?? this.name,
      announce: announce ?? this.announce,
      detail: detail ?? this.detail,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      image: image ?? this.image,
      freight: freight ?? this.freight,
      choose: choose ?? this.choose,
      open: open ?? this.open,
      close: close ?? this.close,
      timetype: timetype ?? this.timetype,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'managerid': managerid,
      'name': name,
      'announce': announce,
      'detail': detail,
      'address': address,
      'phone': phone,
      'lat': lat,
      'lng': lng,
      'image': image,
      'freight': freight,
      'choose': choose,
      'open': open,
      'close': close,
      'timetype': timetype,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'] ?? '',
      managerid: map['managerid'] ?? '',
      name: map['name'] ?? '',
      announce: map['announce'] ?? '',
      detail: map['detail'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      freight: map['freight']?.toInt() ?? 0,
      choose: map['choose']?.toInt() ?? 0,
      open: map['open'] ?? '',
      close: map['close'] ?? '',
      timetype: map['timetype'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) => ShopModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShopModel(id: $id, managerid: $managerid, name: $name, announce: $announce, detail: $detail, address: $address, phone: $phone, lat: $lat, lng: $lng, image: $image, freight: $freight, choose: $choose, open: $open, close: $close, timetype: $timetype, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShopModel &&
      other.id == id &&
      other.managerid == managerid &&
      other.name == name &&
      other.announce == announce &&
      other.detail == detail &&
      other.address == address &&
      other.phone == phone &&
      other.lat == lat &&
      other.lng == lng &&
      other.image == image &&
      other.freight == freight &&
      other.choose == choose &&
      other.open == open &&
      other.close == close &&
      other.timetype == timetype &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      managerid.hashCode ^
      name.hashCode ^
      announce.hashCode ^
      detail.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      image.hashCode ^
      freight.hashCode ^
      choose.hashCode ^
      open.hashCode ^
      close.hashCode ^
      timetype.hashCode ^
      time.hashCode;
  }
}

ShopModel convertShop(dynamic item) {
  return ShopModel(
    id: item.id,
    managerid: item['managerid'],
    name: item['name'],
    announce: item['announce'],
    detail: item['detail'],
    address: item['address'],
    phone: item['phone'],
    lat: item['lat'],
    lng: item['lng'],
    image: item['image'],
    freight: item['freight'],
    choose: item['choose'],
    open: item['open'],
    close: item['close'],
    timetype: item['timetype'],
    time: (item['time'] as Timestamp).toDate(),
  );
}
