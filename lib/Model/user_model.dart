// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String image;
  final String role;
  final int status;
  final String tokenE;
  final String tokenP;
  final DateTime time;
  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.image,
    required this.role,
    required this.status,
    required this.tokenE,
    required this.tokenP,
    required this.time,
  });

  UserModel copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? image,
    String? role,
    int? status,
    String? tokenE,
    String? tokenP,
    DateTime? time,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      role: role ?? this.role,
      status: status ?? this.status,
      tokenE: tokenE ?? this.tokenE,
      tokenP: tokenP ?? this.tokenP,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'image': image,
      'role': role,
      'status': status,
      'tokenE': tokenE,
      'tokenP': tokenP,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      role: map['role'] ?? '',
      status: map['status']?.toInt() ?? 0,
      tokenE: map['tokenE'] ?? '',
      tokenP: map['tokenP'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, image: $image, role: $role, status: $status, tokenE: $tokenE, tokenP: $tokenP, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.phone == phone &&
        other.image == image &&
        other.role == role &&
        other.status == status &&
        other.tokenE == tokenE &&
        other.tokenP == tokenP &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        image.hashCode ^
        role.hashCode ^
        status.hashCode ^
        tokenE.hashCode ^
        tokenP.hashCode ^
        time.hashCode;
  }
}

UserModel convertUser(dynamic item, String? id) {
  return UserModel(
    id: id ?? item.id,
    firstname: item['firstname'],
    lastname: item['lastname'],
    email: item['email'],
    phone: item['phone'],
    image: item['image'],
    role: item['role'],
    status: item['status'],
    tokenE: item['tokenE'],
    tokenP: item['tokenP'],
    time: (item['time'] as Timestamp).toDate(),
  );
}
