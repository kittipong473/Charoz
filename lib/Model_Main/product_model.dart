// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String type;
  final int price;
  final String detail;
  final String image;
  final int status;
  final int suggest;
  final DateTime time;
  ProductModel({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.detail,
    required this.image,
    required this.status,
    required this.suggest,
    required this.time,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? type,
    int? price,
    String? detail,
    String? image,
    int? status,
    int? suggest,
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
    return {
      'id': id,
      'name': name,
      'type': type,
      'price': price,
      'detail': detail,
      'image': image,
      'status': status,
      'suggest': suggest,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      price: map['price']?.toInt() ?? 0,
      detail: map['detail'] ?? '',
      image: map['image'] ?? '',
      status: map['status']?.toInt() ?? 0,
      suggest: map['suggest']?.toInt() ?? 0,
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, type: $type, price: $price, detail: $detail, image: $image, status: $status, suggest: $suggest, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
      other.id == id &&
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

ProductModel convertProduct(dynamic item) {
    return ProductModel(
      id: item.id,
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
