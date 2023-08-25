// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String? id;
  String? name;
  String? url;
  int? type;
  DateTime? time;
  BannerModel({
    this.id,
    this.name,
    this.url,
    this.type,
    this.time,
  });

  BannerModel convert({required dynamic item, String? id}) {
    return BannerModel(
      id: id ?? item.id,
      name: item['name'],
      url: item['url'],
      type: item['type'],
      time: (item['time'] as Timestamp).toDate(),
    );
  }
}
