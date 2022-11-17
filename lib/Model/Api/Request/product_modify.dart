import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductManage {
  final String name;
  final String type;
  final int price;
  final String detail;
  final String image;
  final int status;
  final int suggest;
  final Timestamp time;
  ProductManage({
    required this.name,
    required this.type,
    required this.price,
    required this.detail,
    required this.image,
    required this.status,
    required this.suggest,
    required this.time,
  });

  ProductManage copyWith({
    String? name,
    String? type,
    int? price,
    String? detail,
    String? image,
    int? status,
    int? suggest,
    Timestamp? time,
  }) {
    return ProductManage(
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
    return {
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

  factory ProductManage.fromMap(Map<String, dynamic> map) {
    return ProductManage(
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      price: map['price']?.toInt() ?? 0,
      detail: map['detail'] ?? '',
      image: map['image'] ?? '',
      status: map['status']?.toInt() ?? 0,
      suggest: map['suggest']?.toInt() ?? 0,
      time: map['time'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductManage.fromJson(String source) => ProductManage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubProductModel(name: $name, type: $type, price: $price, detail: $detail, image: $image, status: $status, suggest: $suggest, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductManage &&
      other.name == name &&
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
