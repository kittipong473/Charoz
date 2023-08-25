// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  ProductModel convert({required dynamic item, String? id}) {
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
}
