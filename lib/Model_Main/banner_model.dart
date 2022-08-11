// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String id;
  final String name;
  final String url;
  final DateTime time;
  BannerModel({
    required this.id,
    required this.name,
    required this.url,
    required this.time,
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
    return {
      'id': id,
      'name': name,
      'url': url,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BannerModel(id: $id, name: $name, url: $url, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannerModel &&
        other.id == id &&
        other.name == name &&
        other.url == url &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ url.hashCode ^ time.hashCode;
  }
}

BannerModel convertBanner(dynamic item) {
  return BannerModel(
    id: item.id,
    name: item['name'],
    url: item['url'],
    time: (item['time'] as Timestamp).toDate(),
  );
}
