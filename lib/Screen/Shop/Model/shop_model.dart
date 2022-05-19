import 'dart:convert';

class ShopModel {
  final String shopId;
  final String shopName;
  final String shopAnnounce;
  final String shopDetail;
  final String shopAddress;
  final String shopLat;
  final String shopLng;
  final String shopVideo;
  final String created;
  final String updated;
  ShopModel({
    required this.shopId,
    required this.shopName,
    required this.shopAnnounce,
    required this.shopDetail,
    required this.shopAddress,
    required this.shopLat,
    required this.shopLng,
    required this.shopVideo,
    required this.created,
    required this.updated,
  });

  ShopModel copyWith({
    String? shopId,
    String? shopName,
    String? shopAnnounce,
    String? shopDetail,
    String? shopAddress,
    String? shopLat,
    String? shopLng,
    String? shopVideo,
    String? created,
    String? updated,
  }) {
    return ShopModel(
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      shopAnnounce: shopAnnounce ?? this.shopAnnounce,
      shopDetail: shopDetail ?? this.shopDetail,
      shopAddress: shopAddress ?? this.shopAddress,
      shopLat: shopLat ?? this.shopLat,
      shopLng: shopLng ?? this.shopLng,
      shopVideo: shopVideo ?? this.shopVideo,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'shopName': shopName,
      'shopAnnounce': shopAnnounce,
      'shopDetail': shopDetail,
      'shopAddress': shopAddress,
      'shopLat': shopLat,
      'shopLng': shopLng,
      'shopVideo': shopVideo,
      'created': created,
      'updated': updated,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      shopId: map['shopId'] ?? '',
      shopName: map['shopName'] ?? '',
      shopAnnounce: map['shopAnnounce'] ?? '',
      shopDetail: map['shopDetail'] ?? '',
      shopAddress: map['shopAddress'] ?? '',
      shopLat: map['shopLat'] ?? '',
      shopLng: map['shopLng'] ?? '',
      shopVideo: map['shopVideo'] ?? '',
      created: map['created'] ?? '',
      updated: map['updated'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) => ShopModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShopModel(shopId: $shopId, shopName: $shopName, shopAnnounce: $shopAnnounce, shopDetail: $shopDetail, shopAddress: $shopAddress, shopLat: $shopLat, shopLng: $shopLng, shopVideo: $shopVideo, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShopModel &&
      other.shopId == shopId &&
      other.shopName == shopName &&
      other.shopAnnounce == shopAnnounce &&
      other.shopDetail == shopDetail &&
      other.shopAddress == shopAddress &&
      other.shopLat == shopLat &&
      other.shopLng == shopLng &&
      other.shopVideo == shopVideo &&
      other.created == created &&
      other.updated == updated;
  }

  @override
  int get hashCode {
    return shopId.hashCode ^
      shopName.hashCode ^
      shopAnnounce.hashCode ^
      shopDetail.hashCode ^
      shopAddress.hashCode ^
      shopLat.hashCode ^
      shopLng.hashCode ^
      shopVideo.hashCode ^
      created.hashCode ^
      updated.hashCode;
  }
}
