import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseSendOTP {
  String? status;
  String? token;
  String? refno;
  ResponseSendOTP({
    this.status,
    this.token,
    this.refno,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'token': token,
      'refno': refno,
    };
  }

  factory ResponseSendOTP.fromMap(Map<String, dynamic> map) {
    return ResponseSendOTP(
      status: map['status'] != null ? map['status'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      refno: map['refno'] != null ? map['refno'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseSendOTP.fromJson(String source) =>
      ResponseSendOTP.fromMap(json.decode(source) as Map<String, dynamic>);
}
