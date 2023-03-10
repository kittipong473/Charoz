// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ShopManagerRequest {
  String? name;
  String? announce;
  String? detail;
  String? phone;
  String? image;
  int? freight;
  Timestamp? time;
  ShopManagerRequest({
    this.name,
    this.announce,
    this.detail,
    this.phone,
    this.image,
    this.freight,
    this.time,
  });

  ShopManagerRequest copyWith({
    String? name,
    String? announce,
    String? detail,
    String? phone,
    String? image,
    int? freight,
    Timestamp? time,
  }) {
    return ShopManagerRequest(
      name: name ?? this.name,
      announce: announce ?? this.announce,
      detail: detail ?? this.detail,
      phone: phone ?? this.phone,
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
      'phone': phone,
      'image': image,
      'freight': freight,
      'time': time,
    };
  }

  factory ShopManagerRequest.fromMap(Map<String, dynamic> map) {
    return ShopManagerRequest(
      name: map['name'] != null ? map['name'] as String : null,
      announce: map['announce'] != null ? map['announce'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      freight: map['freight'] != null ? map['freight'] as int : null,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopManagerRequest.fromJson(String source) =>
      ShopManagerRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopManagerManage(name: $name, announce: $announce, detail: $detail, phone: $phone, image: $image, freight: $freight, time: $time)';
  }

  @override
  bool operator ==(covariant ShopManagerRequest other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.announce == announce &&
        other.detail == detail &&
        other.phone == phone &&
        other.image == image &&
        other.freight == freight &&
        other.time == time;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        announce.hashCode ^
        detail.hashCode ^
        phone.hashCode ^
        image.hashCode ^
        freight.hashCode ^
        time.hashCode;
  }
}
