
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class NotiModify {
  int? type;
  String? name;
  String? detail;
  int? receive;
  bool? status;
  Timestamp? time;
  NotiModify({
    this.type,
    this.name,
    this.detail,
    this.receive,
    this.status,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'detail': detail,
      'receive': receive,
      'status': status,
      'time': time,
    };
  }
}
