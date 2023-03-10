// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ShopAdminRequest {
  String? name;
  String? announce;
  String? detail;
  String? address;
  String? phone;
  double? lat;
  double? lng;
  String? image;
  int? freight;
  Timestamp? time;
  ShopAdminRequest({
    this.name,
    this.announce,
    this.detail,
    this.address,
    this.phone,
    this.lat,
    this.lng,
    this.image,
    this.freight,
    this.time,
  });

  ShopAdminRequest copyWith({
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
    return ShopAdminRequest(
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
    return <String, dynamic>{
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

  factory ShopAdminRequest.fromMap(Map<String, dynamic> map) {
    return ShopAdminRequest(
      name: map['name'] != null ? map['name'] as String : null,
      announce: map['announce'] != null ? map['announce'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      lng: map['lng'] != null ? map['lng'] as double : null,
      image: map['image'] != null ? map['image'] as String : null,
      freight: map['freight'] != null ? map['freight'] as int : null,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopAdminRequest.fromJson(String source) =>
      ShopAdminRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopAdminRequest(name: $name, announce: $announce, detail: $detail, address: $address, phone: $phone, lat: $lat, lng: $lng, image: $image, freight: $freight, time: $time)';
  }

  @override
  bool operator ==(covariant ShopAdminRequest other) {
    if (identical(this, other)) return true;

    return other.name == name &&
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
