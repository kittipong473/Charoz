import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ShopManagerModify {
  final String name;
  final String announce;
  final String detail;
  final String phone;
  final String image;
  final int freight;
  final Timestamp time;
  ShopManagerModify({
    required this.name,
    required this.announce,
    required this.detail,
    required this.phone,
    required this.image,
    required this.freight,
    required this.time,
  });

  ShopManagerModify copyWith({
    String? name,
    String? announce,
    String? detail,
    String? phone,
    String? image,
    int? freight,
    Timestamp? time,
  }) {
    return ShopManagerModify(
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
    return {
      'name': name,
      'announce': announce,
      'detail': detail,
      'phone': phone,
      'image': image,
      'freight': freight,
      'time': time,
    };
  }

  factory ShopManagerModify.fromMap(Map<String, dynamic> map) {
    return ShopManagerModify(
      name: map['name'] ?? '',
      announce: map['announce'] ?? '',
      detail: map['detail'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      freight: map['freight']?.toInt() ?? 0,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopManagerModify.fromJson(String source) => ShopManagerModify.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubShopManagerModel(name: $name, announce: $announce, detail: $detail, phone: $phone, image: $image, freight: $freight, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShopManagerModify &&
      other.name == name &&
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
