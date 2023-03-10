// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserRequest {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  int? role;
  bool? status;
  String? tokenE;
  String? tokenP;
  String? tokenDevice;
  Timestamp? time;
  UserRequest({
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.role,
    this.status,
    this.tokenE,
    this.tokenP,
    this.tokenDevice,
    this.time,
  });

  UserRequest copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    int? role,
    bool? status,
    String? tokenE,
    String? tokenP,
    String? tokenDevice,
    Timestamp? time,
  }) {
    return UserRequest(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
      tokenE: tokenE ?? this.tokenE,
      tokenP: tokenP ?? this.tokenP,
      tokenDevice: tokenDevice ?? this.tokenDevice,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'role': role,
      'status': status,
      'tokenE': tokenE,
      'tokenP': tokenP,
      'tokenDevice': tokenDevice,
      'time': time,
    };
  }

  factory UserRequest.fromMap(Map<String, dynamic> map) {
    return UserRequest(
      firstname: map['firstname'] != null ? map['firstname'] as String : null,
      lastname: map['lastname'] != null ? map['lastname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      role: map['role'] != null ? map['role'] as int : null,
      status: map['status'] != null ? map['status'] as bool : null,
      tokenE: map['tokenE'] != null ? map['tokenE'] as String : null,
      tokenP: map['tokenP'] != null ? map['tokenP'] as String : null,
      tokenDevice:
          map['tokenDevice'] != null ? map['tokenDevice'] as String : null,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequest.fromJson(String source) =>
      UserRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserRequest(firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, role: $role, status: $status, tokenE: $tokenE, tokenP: $tokenP, tokenDevice: $tokenDevice, time: $time)';
  }

  @override
  bool operator ==(covariant UserRequest other) {
    if (identical(this, other)) return true;

    return other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.phone == phone &&
        other.role == role &&
        other.status == status &&
        other.tokenE == tokenE &&
        other.tokenP == tokenP &&
        other.tokenDevice == tokenDevice &&
        other.time == time;
  }

  @override
  int get hashCode {
    return firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        role.hashCode ^
        status.hashCode ^
        tokenE.hashCode ^
        tokenP.hashCode ^
        tokenDevice.hashCode ^
        time.hashCode;
  }
}
