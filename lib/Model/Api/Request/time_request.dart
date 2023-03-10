// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeRequest {
  String? shopid;
  String? mon;
  String? tue;
  String? wed;
  String? thu;
  String? fri;
  String? sat;
  String? sun;
  int? choose;
  TimeRequest({
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

  TimeRequest copyWith({
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
    return TimeRequest(
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

  factory TimeRequest.fromMap(Map<String, dynamic> map) {
    return TimeRequest(
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

  factory TimeRequest.fromJson(String source) =>
      TimeRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeRequest(shopid: $shopid, mon: $mon, tue: $tue, wed: $wed, thu: $thu, fri: $fri, sat: $sat, sun: $sun, choose: $choose)';
  }

  @override
  bool operator ==(covariant TimeRequest other) {
    if (identical(this, other)) return true;

    return other.shopid == shopid &&
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
    return shopid.hashCode ^
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
