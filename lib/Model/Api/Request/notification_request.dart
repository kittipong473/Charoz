import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationRequest {
  String? token;
  String? title;
  String? body;
  NotificationPayload? payload;
  NotificationRequest({
    this.token,
    this.title,
    this.body,
    this.payload,
  });
}

class NotificationPayload {
  String? id;
  String? name;
  String? detail;
  NotificationPayload({
    this.id,
    this.name,
    this.detail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'detail': detail,
    };
  }

  factory NotificationPayload.fromMap(Map<String, dynamic> map) {
    return NotificationPayload(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationPayload.fromJson(String source) =>
      NotificationPayload.fromMap(json.decode(source) as Map<String, dynamic>);
}
