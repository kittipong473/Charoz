// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  String? id;
  String? managerid;
  String? name;
  String? announce;
  String? detail;
  String? address;
  String? phone;
  double? lat;
  double? lng;
  String? image;
  int? freight;
  DateTime? time;
  ShopModel({
    this.id,
    this.managerid,
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
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      'time': time,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'] != null ? map['id'] as String : null,
      managerid: map['managerid'] != null ? map['managerid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      announce: map['announce'] != null ? map['announce'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      lng: map['lng'] != null ? map['lng'] as double : null,
      image: map['image'] != null ? map['image'] as String : null,
      freight: map['freight'] != null ? map['freight'] as int : null,
      time: map['time'] != null ? (map['time'] as Timestamp).toDate() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopModel(id: $id, managerid: $managerid, name: $name, announce: $announce, detail: $detail, address: $address, phone: $phone, lat: $lat, lng: $lng, image: $image, freight: $freight, time: $time)';
  }

  @override
  bool operator ==(covariant ShopModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
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
        time.hashCode;
  }
}

ShopModel convertShop(dynamic item, String? id) {
  return ShopModel(
    id: id ?? item.id,
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
    time: (item['time'] as Timestamp).toDate(),
  );
}
