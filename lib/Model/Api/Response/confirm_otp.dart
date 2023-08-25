import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseConfirmOTP {
  String? status;
  String? message;
  ResponseConfirmOTP({
    this.status,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
    };
  }

  factory ResponseConfirmOTP.fromMap(Map<String, dynamic> map) {
    return ResponseConfirmOTP(
      status: map['status'] != null ? map['status'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseConfirmOTP.fromJson(String source) =>
      ResponseConfirmOTP.fromMap(json.decode(source) as Map<String, dynamic>);
}
