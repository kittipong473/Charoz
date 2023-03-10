// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BannerRequest {
  String? name;
  String? url;
  Timestamp? time;
  BannerRequest({
    this.name,
    this.url,
    this.time,
  });

  BannerRequest copyWith({
    String? name,
    String? url,
    Timestamp? time,
  }) {
    return BannerRequest(
      name: name ?? this.name,
      url: url ?? this.url,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
      'time': time,
    };
  }

  factory BannerRequest.fromMap(Map<String, dynamic> map) {
    return BannerRequest(
      name: map['name'] != null ? map['name'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerRequest.fromJson(String source) =>
      BannerRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BannerRequest(name: $name, url: $url, time: $time)';

  @override
  bool operator ==(covariant BannerRequest other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url && other.time == time;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode ^ time.hashCode;
}
