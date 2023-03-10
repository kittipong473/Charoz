// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String? id;
  String? name;
  String? url;
  DateTime? time;
  BannerModel({
    this.id,
    this.name,
    this.url,
    this.time,
  });

  BannerModel copyWith({
    String? id,
    String? name,
    String? url,
    DateTime? time,
  }) {
    return BannerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'url': url,
      'time': time,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      time: map['time'] != null ? (map['time'] as Timestamp).toDate() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BannerModel(id: $id, name: $name, url: $url, time: $time)';
  }

  @override
  bool operator ==(covariant BannerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.url == url &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ url.hashCode ^ time.hashCode;
  }
}

BannerModel convertBanner(dynamic item, String? id) {
  return BannerModel(
    id: id ?? item.id,
    name: item['name'],
    url: item['url'],
    time: (item['time'] as Timestamp).toDate(),
  );
}
