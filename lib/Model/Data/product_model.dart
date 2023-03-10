// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String? name;
  int? type;
  int? price;
  String? detail;
  String? image;
  bool? status;
  bool? suggest;
  DateTime? time;
  ProductModel({
    this.id,
    this.name,
    this.type,
    this.price,
    this.detail,
    this.image,
    this.status,
    this.suggest,
    this.time,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    int? type,
    int? price,
    String? detail,
    String? image,
    bool? status,
    bool? suggest,
    DateTime? time,
  }) {
    return ProductModel(
      id: id ?? this.id,
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
      'id': id,
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

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as int : null,
      price: map['price'] != null ? map['price'] as int : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      suggest: map['suggest'] != null ? map['suggest'] as bool : null,
      time: map['time'] != null ? (map['time'] as Timestamp).toDate() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, type: $type, price: $price, detail: $detail, image: $image, status: $status, suggest: $suggest, time: $time)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
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
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        price.hashCode ^
        detail.hashCode ^
        image.hashCode ^
        status.hashCode ^
        suggest.hashCode ^
        time.hashCode;
  }
}

ProductModel convertProduct(dynamic item, String? id) {
  return ProductModel(
    id: id ?? item.id,
    name: item['name'],
    type: item['type'],
    price: item['price'],
    detail: item['detail'],
    image: item['image'],
    status: item['status'],
    suggest: item['suggest'],
    time: (item['time'] as Timestamp).toDate(),
  );
}
