import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ShopAdminManage {
  final String name;
  final String announce;
  final String detail;
  final String address;
  final String phone;
  final double lat;
  final double lng;
  final String image;
  final int freight;
  final Timestamp time;
  ShopAdminManage({
    required this.name,
    required this.announce,
    required this.detail,
    required this.address,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.image,
    required this.freight,
    required this.time,
  });

  ShopAdminManage copyWith({
    String? name,
    String? announce,
    String? detail,
    String? address,
    String? phone,
    double? lat,
    double? lng,
    String? image,
    int? freight,
    Timestamp? time,
  }) {
    return ShopAdminManage(
      name: name ?? this.name,
      announce: announce ?? this.announce,
      detail: detail ?? this.detail,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      image: image ?? this.image,
      freight: freight ?? this.freight,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'announce': announce,
      'detail': detail,
      'address': address,
      'phone': phone,
      'lat': lat,
      'lng': lng,
      'image': image,
      'freight': freight,
      'time': time,
    };
  }

  factory ShopAdminManage.fromMap(Map<String, dynamic> map) {
    return ShopAdminManage(
      name: map['name'] ?? '',
      announce: map['announce'] ?? '',
      detail: map['detail'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      freight: map['freight']?.toInt() ?? 0,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopAdminManage.fromJson(String source) => ShopAdminManage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShopAdminManage(name: $name, announce: $announce, detail: $detail, address: $address, phone: $phone, lat: $lat, lng: $lng, image: $image, freight: $freight, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShopAdminManage &&
      other.name == name &&
      other.announce == announce &&
      other.detail == detail &&
      other.address == address &&
      other.phone == phone &&
      other.lat == lat &&
      other.lng == lng &&
      other.image == image &&
      other.freight == freight &&
      other.time == time;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      announce.hashCode ^
      detail.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      image.hashCode ^
      freight.hashCode ^
      time.hashCode;
  }
}
