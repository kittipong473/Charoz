// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  UserModel convert({required dynamic item, String? id}) {
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
}
