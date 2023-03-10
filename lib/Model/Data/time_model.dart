// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeModel {
  String? id;
  String? shopid;
  String? mon;
  String? tue;
  String? wed;
  String? thu;
  String? fri;
  String? sat;
  String? sun;
  int? choose;
  TimeModel({
    this.id,
    this.shopid,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
    this.sun,
    this.choose,
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
    int? choose,
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
      choose: choose ?? this.choose,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'shopid': shopid,
      'mon': mon,
      'tue': tue,
      'wed': wed,
      'thu': thu,
      'fri': fri,
      'sat': sat,
      'sun': sun,
      'choose': choose,
    };
  }

  factory TimeModel.fromMap(Map<String, dynamic> map) {
    return TimeModel(
      id: map['id'] != null ? map['id'] as String : null,
      shopid: map['shopid'] != null ? map['shopid'] as String : null,
      mon: map['mon'] != null ? map['mon'] as String : null,
      tue: map['tue'] != null ? map['tue'] as String : null,
      wed: map['wed'] != null ? map['wed'] as String : null,
      thu: map['thu'] != null ? map['thu'] as String : null,
      fri: map['fri'] != null ? map['fri'] as String : null,
      sat: map['sat'] != null ? map['sat'] as String : null,
      sun: map['sun'] != null ? map['sun'] as String : null,
      choose: map['choose'] != null ? map['choose'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeModel.fromJson(String source) =>
      TimeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeModel(id: $id, shopid: $shopid, mon: $mon, tue: $tue, wed: $wed, thu: $thu, fri: $fri, sat: $sat, sun: $sun, choose: $choose)';
  }

  @override
  bool operator ==(covariant TimeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.shopid == shopid &&
        other.mon == mon &&
        other.tue == tue &&
        other.wed == wed &&
        other.thu == thu &&
        other.fri == fri &&
        other.sat == sat &&
        other.sun == sun &&
        other.choose == choose;
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
        choose.hashCode;
  }
}

TimeModel convertTime(dynamic item, String? id) {
  return TimeModel(
    id: id ?? item.id,
    shopid: item['shopid'],
    mon: item['mon'],
    tue: item['tue'],
    wed: item['wed'],
    thu: item['thu'],
    fri: item['fri'],
    sat: item['sat'],
    sun: item['sun'],
    choose: item['choose'],
  );
}
