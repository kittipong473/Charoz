import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TimeModel {
  final String id;
  final String shopid;
  final String mon;
  final String tue;
  final String wed;
  final String thu;
  final String fri;
  final String sat;
  final String sun;
  final String type;
  final int choose;
  final DateTime time;
  TimeModel({
    required this.id,
    required this.shopid,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
    required this.type,
    required this.choose,
    required this.time,
  });

  TimeModel copyWith({
    String? id,
    String? shopid,
    String? mon,
    String? tue,
    String? wed,
    String? thu,
    String? fri,
    String? sat,
    String? sun,
    String? type,
    int? choose,
    DateTime? time,
  }) {
    return TimeModel(
      id: id ?? this.id,
      shopid: shopid ?? this.shopid,
      mon: mon ?? this.mon,
      tue: tue ?? this.tue,
      wed: wed ?? this.wed,
      thu: thu ?? this.thu,
      fri: fri ?? this.fri,
      sat: sat ?? this.sat,
      sun: sun ?? this.sun,
      type: type ?? this.type,
      choose: choose ?? this.choose,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopid': shopid,
      'mon': mon,
      'tue': tue,
      'wed': wed,
      'thu': thu,
      'fri': fri,
      'sat': sat,
      'sun': sun,
      'type': type,
      'choose': choose,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory TimeModel.fromMap(Map<String, dynamic> map) {
    return TimeModel(
      id: map['id'] ?? '',
      shopid: map['shopid'] ?? '',
      mon: map['mon'] ?? '',
      tue: map['tue'] ?? '',
      wed: map['wed'] ?? '',
      thu: map['thu'] ?? '',
      fri: map['fri'] ?? '',
      sat: map['sat'] ?? '',
      sun: map['sun'] ?? '',
      type: map['type'] ?? '',
      choose: map['choose']?.toInt() ?? 0,
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeModel.fromJson(String source) =>
      TimeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TimeModel(id: $id, shopid: $shopid, mon: $mon, tue: $tue, wed: $wed, thu: $thu, fri: $fri, sat: $sat, sun: $sun, type: $type, choose: $choose, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeModel &&
        other.id == id &&
        other.shopid == shopid &&
        other.mon == mon &&
        other.tue == tue &&
        other.wed == wed &&
        other.thu == thu &&
        other.fri == fri &&
        other.sat == sat &&
        other.sun == sun &&
        other.type == type &&
        other.choose == choose &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        shopid.hashCode ^
        mon.hashCode ^
        tue.hashCode ^
        wed.hashCode ^
        thu.hashCode ^
        fri.hashCode ^
        sat.hashCode ^
        sun.hashCode ^
        type.hashCode ^
        choose.hashCode ^
        time.hashCode;
  }
}

TimeModel convertTime(dynamic item) {
  return TimeModel(
    id: item.id,
    shopid: item['shopid'],
    mon: item['mon'],
    tue: item['tue'],
    wed: item['wed'],
    thu: item['thu'],
    fri: item['fri'],
    sat: item['sat'],
    sun: item['sun'],
    type: item['type'],
    choose: item['choose'],
    time: (item['time'] as Timestamp).toDate(),
  );
}
