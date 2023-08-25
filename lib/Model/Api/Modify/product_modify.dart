// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModify {
  String? name;
  String? type;
  int? price;
  String? detail;
  String? image;
  bool? status;
  bool? suggest;
  Timestamp? time;
  ProductModify({
    this.name,
    this.type,
    this.price,
    this.detail,
    this.image,
    this.status,
    this.suggest,
    this.time,
  });

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
}
