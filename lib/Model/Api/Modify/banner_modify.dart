// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModify {
  String? name;
  String? url;
  int? type;
  Timestamp? time;
  BannerModify({
    this.name,
    this.url,
    this.type,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
      'type': type,
      'time': time,
    };
  }
}
