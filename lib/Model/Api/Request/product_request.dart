// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRequest {
  String? name;
  String? type;
  int? price;
  String? detail;
  String? image;
  bool? status;
  bool? suggest;
  Timestamp? time;
  ProductRequest({
    this.name,
    this.type,
    this.price,
    this.detail,
    this.image,
    this.status,
    this.suggest,
    this.time,
  });

  ProductRequest copyWith({
    String? name,
    String? type,
    int? price,
    String? detail,
    String? image,
    bool? status,
    bool? suggest,
    Timestamp? time,
  }) {
    return ProductRequest(
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      detail: detail ?? this.detail,
      image: image ?? this.image,
      status: status ?? this.status,
      suggest: suggest ?? this.suggest,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'price': price,
      'detail': detail,
      'image': image,
      'status': status,
      'suggest': suggest,
      'time': time,
    };
  }

  factory ProductRequest.fromMap(Map<String, dynamic> map) {
    return ProductRequest(
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      suggest: map['suggest'] != null ? map['suggest'] as bool : null,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductRequest.fromJson(String source) =>
      ProductRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductRequest(name: $name, type: $type, price: $price, detail: $detail, image: $image, status: $status, suggest: $suggest, time: $time)';
  }

  @override
  bool operator ==(covariant ProductRequest other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.type == type &&
        other.price == price &&
        other.detail == detail &&
        other.image == image &&
        other.status == status &&
        other.suggest == suggest &&
        other.time == time;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        price.hashCode ^
        detail.hashCode ^
        image.hashCode ^
        status.hashCode ^
        suggest.hashCode ^
        time.hashCode;
  }
}
