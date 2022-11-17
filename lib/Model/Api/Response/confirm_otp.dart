import 'dart:convert';

class ResponseConfirmOTP {
  final String status;
  final String message;
  ResponseConfirmOTP({
    required this.status,
    required this.message,
  });

  ResponseConfirmOTP copyWith({
    String? status,
    String? message,
  }) {
    return ResponseConfirmOTP(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory ResponseConfirmOTP.fromMap(Map<String, dynamic> map) {
    return ResponseConfirmOTP(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseConfirmOTP.fromJson(String source) => ResponseConfirmOTP.fromMap(json.decode(source));

  @override
  String toString() => 'ConfirmOTPModel(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ResponseConfirmOTP &&
      other.status == status &&
      other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
