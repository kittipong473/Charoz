// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  int? role;
  bool? status;
  String? token;
  DateTime? create;
  DateTime? update;
  UserModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.role,
    this.status,
    this.token,
    this.create,
    this.update,
  });

  UserModel copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    int? role,
    bool? status,
    String? token,
    DateTime? create,
    DateTime? update,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
      token: token ?? this.token,
      create: create ?? this.create,
      update: update ?? this.update,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'role': role,
      'status': status,
      'token': token,
      'create': create,
      'update': update,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      firstname: map['firstname'] != null ? map['firstname'] as String : null,
      lastname: map['lastname'] != null ? map['lastname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      role: map['role'] != null ? map['role'] as int : null,
      status: map['status'] != null ? map['status'] as bool : null,
      token: map['token'] != null ? map['token'] as String : null,
      create:
          map['create'] != null ? (map['create'] as Timestamp).toDate() : null,
      update:
          map['update'] != null ? (map['update'] as Timestamp).toDate() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, role: $role, status: $status, token: $token, create: $create, update: $update)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.phone == phone &&
        other.role == role &&
        other.status == status &&
        other.token == token &&
        other.create == create &&
        other.update == update;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        role.hashCode ^
        status.hashCode ^
        token.hashCode ^
        create.hashCode ^
        update.hashCode;
  }
}

UserModel convertUser(dynamic item, String? id) {
  return UserModel(
    id: id ?? item.id,
    firstname: item['firstname'],
    lastname: item['lastname'],
    email: item['email'],
    phone: item['phone'],
    role: item['role'],
    status: item['status'],
    token: item['token'],
    create: (item['create'] as Timestamp).toDate(),
    update: (item['update'] as Timestamp).toDate(),
  );
}
