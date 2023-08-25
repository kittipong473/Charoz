// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class NotiModel {
  String? id;
  int? type;
  String? name;
  String? detail;
  bool? guest;
  bool? customer;
  bool? rider;
  bool? manager;
  bool? status;
  DateTime? time;
  NotiModel({
    this.id,
    this.type,
    this.name,
    this.detail,
    this.guest,
    this.customer,
    this.rider,
    this.manager,
    this.status,
    this.time,
  });

  NotiModel convert({required dynamic item, String? id}) {
    return NotiModel(
      id: id ?? item.id,
      type: item['type'],
      name: item['name'],
      detail: item['detail'],
      guest: item['guest'],
      customer: item['customer'],
      rider: item['rider'],
      manager: item['manager'],
      status: item['status'],
      time: (item['time'] as Timestamp).toDate(),
    );
  }
}
