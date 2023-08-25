// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  int? freight;
  String? mon;
  String? tue;
  String? wed;
  String? thu;
  String? fri;
  String? sat;
  String? sun;
  int? chooseTime;
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
    this.freight,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
    this.sun,
    this.chooseTime,
    this.time,
  });

  ShopModel convert({required dynamic item, String? id}) {
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
      freight: item['freight'],
      mon: item['mon'],
      tue: item['tue'],
      wed: item['wed'],
      thu: item['thu'],
      fri: item['fri'],
      sat: item['sat'],
      sun: item['sun'],
      chooseTime: item['chooseTime'],
      time: (item['time'] as Timestamp).toDate(),
    );
  }
}
