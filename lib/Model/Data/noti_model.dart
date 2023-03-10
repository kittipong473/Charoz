// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  NotiModel copyWith({
    String? id,
    int? type,
    String? name,
    String? detail,
    bool? guest,
    bool? customer,
    bool? rider,
    bool? manager,
    bool? status,
    DateTime? time,
  }) {
    return NotiModel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      guest: guest ?? this.guest,
      customer: customer ?? this.customer,
      rider: rider ?? this.rider,
      manager: manager ?? this.manager,
      status: status ?? this.status,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'name': name,
      'detail': detail,
      'guest': guest,
      'customer': customer,
      'rider': rider,
      'manager': manager,
      'status': status,
      'time': time,
    };
  }

  factory NotiModel.fromMap(Map<String, dynamic> map) {
    return NotiModel(
      id: map['id'] != null ? map['id'] as String : null,
      type: map['type'] != null ? map['type'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      guest: map['guest'] != null ? map['guest'] as bool : null,
      customer: map['customer'] != null ? map['customer'] as bool : null,
      rider: map['rider'] != null ? map['rider'] as bool : null,
      manager: map['manager'] != null ? map['manager'] as bool : null,
      status: map['status'] != null ? map['status'] as bool : null,
      time: map['time'] != null ? (map['time'] as Timestamp).toDate() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiModel.fromJson(String source) =>
      NotiModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotiModel(id: $id, type: $type, name: $name, detail: $detail, guest: $guest, customer: $customer, rider: $rider, manager: $manager, status: $status, time: $time)';
  }

  @override
  bool operator ==(covariant NotiModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.name == name &&
        other.detail == detail &&
        other.guest == guest &&
        other.customer == customer &&
        other.rider == rider &&
        other.manager == manager &&
        other.status == status &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        name.hashCode ^
        detail.hashCode ^
        guest.hashCode ^
        customer.hashCode ^
        rider.hashCode ^
        manager.hashCode ^
        status.hashCode ^
        time.hashCode;
  }
}

NotiModel convertNoti(dynamic item, String? id) {
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
