// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModify {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  int? role;
  bool? status;
  String? token;
  Timestamp? create;
  Timestamp? update;
  UserModify({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
}
