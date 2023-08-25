// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModify {
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
  UserModify({
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
}
