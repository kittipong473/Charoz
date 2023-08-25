
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModify {
  String? userid;
  int? type;
  String? detail;
  double? lat;
  double? lng;
  Timestamp? time;
  AddressModify({
    this.userid,
    this.type,
    this.detail,
    this.lat,
    this.lng,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'type': type,
      'detail': detail,
      'lat': lat,
      'lng': lng,
      'time': time,
    };
  }
}
