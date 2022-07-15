// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BannerModel {
  final int bannerId;
  final String bannerName;
  final String bannerUrl;
  final DateTime created;
  BannerModel({
    required this.bannerId,
    required this.bannerName,
    required this.bannerUrl,
    required this.created,
  });

  BannerModel copyWith({
    int? bannerId,
    String? bannerName,
    String? bannerUrl,
    DateTime? created,
  }) {
    return BannerModel(
      bannerId: bannerId ?? this.bannerId,
      bannerName: bannerName ?? this.bannerName,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bannerId': bannerId,
      'bannerName': bannerName,
      'bannerUrl': bannerUrl,
      'created': created.millisecondsSinceEpoch,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      bannerId: map['bannerId'] as int,
      bannerName: map['bannerName'] as String,
      bannerUrl: map['bannerUrl'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BannerModel(bannerId: $bannerId, bannerName: $bannerName, bannerUrl: $bannerUrl, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannerModel &&
        other.bannerId == bannerId &&
        other.bannerName == bannerName &&
        other.bannerUrl == bannerUrl &&
        other.created == created;
  }

  @override
  int get hashCode {
    return bannerId.hashCode ^
        bannerName.hashCode ^
        bannerUrl.hashCode ^
        created.hashCode;
  }
}

BannerModel convertBanner(dynamic item) {
  return BannerModel(
    bannerId: int.parse(item['bannerId']),
    bannerName: item['bannerName'],
    bannerUrl: item['bannerUrl'],
    created: DateTime.parse(item['created']),
  );
}
