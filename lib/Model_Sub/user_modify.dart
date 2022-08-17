import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModify {
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String image;
  final String role;
  final int status;
  final String tokenE;
  final String tokenP;
  final String pincode;
  final Timestamp time;
  UserModify({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.image,
    required this.role,
    required this.status,
    required this.tokenE,
    required this.tokenP,
    required this.pincode,
    required this.time,
  });

  UserModify copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? image,
    String? role,
    int? status,
    String? tokenE,
    String? tokenP,
    String? pincode,
    Timestamp? time,
  }) {
    return UserModify(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      role: role ?? this.role,
      status: status ?? this.status,
      tokenE: tokenE ?? this.tokenE,
      tokenP: tokenP ?? this.tokenP,
      pincode: pincode ?? this.pincode,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'image': image,
      'role': role,
      'status': status,
      'tokenE': tokenE,
      'tokenP': tokenP,
      'pincode': pincode,
      'time': time,
    };
  }

  factory UserModify.fromMap(Map<String, dynamic> map) {
    return UserModify(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      role: map['role'] ?? '',
      status: map['status']?.toInt() ?? 0,
      tokenE: map['tokenE'] ?? '',
      tokenP: map['tokenP'] ?? '',
      pincode: map['pincode'] ?? '',
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModify.fromJson(String source) =>
      UserModify.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModify(firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, image: $image, role: $role, status: $status, tokenE: $tokenE, tokenP: $tokenP, pincode: $pincode, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModify &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.phone == phone &&
        other.image == image &&
        other.role == role &&
        other.status == status &&
        other.tokenE == tokenE &&
        other.tokenP == tokenP &&
        other.pincode == pincode &&
        other.time == time;
  }

  @override
  int get hashCode {
    return firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        image.hashCode ^
        role.hashCode ^
        status.hashCode ^
        tokenE.hashCode ^
        tokenP.hashCode ^
        pincode.hashCode ^
        time.hashCode;
  }
}
