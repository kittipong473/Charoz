// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationRequest {
  final String token;
  final String title;
  final String body;
  final String id;
  final String status;
  NotificationRequest({
    required this.token,
    required this.title,
    required this.body,
    required this.id,
    required this.status,
  });

  NotificationRequest copyWith({
    String? token,
    String? title,
    String? body,
    String? id,
    String? status,
  }) {
    return NotificationRequest(
      token: token ?? this.token,
      title: title ?? this.title,
      body: body ?? this.body,
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'title': title,
      'body': body,
      'id': id,
      'status': status,
    };
  }

  factory NotificationRequest.fromMap(Map<String, dynamic> map) {
    return NotificationRequest(
      token: map['token'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      id: map['id'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationRequest.fromJson(String source) =>
      NotificationRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApiNotificationModel(token: $token, title: $title, body: $body, id: $id, status: $status)';
  }

  @override
  bool operator ==(covariant NotificationRequest other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.title == title &&
        other.body == body &&
        other.id == id &&
        other.status == status;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        title.hashCode ^
        body.hashCode ^
        id.hashCode ^
        status.hashCode;
  }
}
