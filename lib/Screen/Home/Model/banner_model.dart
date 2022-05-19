import 'dart:convert';

class BannerModel {
  final String bannerId;
  final String bannerName;
  final String bannerUrl;
  final String created;
  BannerModel({
    required this.bannerId,
    required this.bannerName,
    required this.bannerUrl,
    required this.created,
  });

  BannerModel copyWith({
    String? bannerId,
    String? bannerName,
    String? bannerUrl,
    String? created,
  }) {
    return BannerModel(
      bannerId: bannerId ?? this.bannerId,
      bannerName: bannerName ?? this.bannerName,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bannerId': bannerId,
      'bannerName': bannerName,
      'bannerUrl': bannerUrl,
      'created': created,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      bannerId: map['bannerId'] ?? '',
      bannerName: map['bannerName'] ?? '',
      bannerUrl: map['bannerUrl'] ?? '',
      created: map['created'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) => BannerModel.fromMap(json.decode(source));

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
