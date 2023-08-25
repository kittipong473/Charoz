// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String? id;
  String? userid;
  int? type;
  String? detail;
  double? lat;
  double? lng;
  DateTime? time;
  AddressModel({
    this.id,
    this.userid,
    this.type,
    this.detail,
    this.lat,
    this.lng,
    this.time,
  });

  AddressModel convert({required dynamic item, String? id}) {
    return AddressModel(
      id: id ?? item.id,
      userid: item['userid'],
      type: item['type'],
      detail: item['detail'],
      lat: item['lat'],
      lng: item['lng'],
      time: (item['time'] as Timestamp).toDate(),
    );
  }
}
