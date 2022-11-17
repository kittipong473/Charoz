import 'dart:convert';

class ResponseSendOTP {
  final String status;
  final String token;
  final String refno;
  ResponseSendOTP({
    required this.status,
    required this.token,
    required this.refno,
  });

  ResponseSendOTP copyWith({
    String? status,
    String? token,
    String? refno,
  }) {
    return ResponseSendOTP(
      status: status ?? this.status,
      token: token ?? this.token,
      refno: refno ?? this.refno,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'token': token,
      'refno': refno,
    };
  }

  factory ResponseSendOTP.fromMap(Map<String, dynamic> map) {
    return ResponseSendOTP(
      status: map['status'] ?? '',
      token: map['token'] ?? '',
      refno: map['refno'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseSendOTP.fromJson(String source) => ResponseSendOTP.fromMap(json.decode(source));

  @override
  String toString() => 'RequestOTPModel(status: $status, token: $token, refno: $refno)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ResponseSendOTP &&
      other.status == status &&
      other.token == token &&
      other.refno == refno;
  }

  @override
  int get hashCode => status.hashCode ^ token.hashCode ^ refno.hashCode;
}
