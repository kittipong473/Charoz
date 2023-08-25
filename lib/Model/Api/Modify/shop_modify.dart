// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModify {
  String? name;
  String? announce;
  String? detail;
  String? address;
  String? phone;
  double? lat;
  double? lng;
  int? freight;
  Timestamp? time;
  ShopModify({
    this.name,
    this.announce,
    this.detail,
    this.address,
    this.phone,
    this.lat,
    this.lng,
    this.freight,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'announce': announce,
      'detail': detail,
      'address': address,
      'phone': phone,
      'lat': lat,
      'lng': lng,
      'freight': freight,
      'time': time,
    };
  }
}
