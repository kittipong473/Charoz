// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShopModel {
  final int shopId;
  final String shopName;
  final String shopAnnounce;
  final String shopDetail;
  final String shopAddress;
  final double shopLat;
  final double shopLng;
  final String shopVideo;
  final DateTime created;
  final DateTime updated;
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
    int? shopId,
    String? shopName,
    String? shopAnnounce,
    String? shopDetail,
    String? shopAddress,
    double? shopLat,
    double? shopLng,
    String? shopVideo,
    DateTime? created,
    DateTime? updated,
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
    return <String, dynamic>{
      'shopId': shopId,
      'shopName': shopName,
      'shopAnnounce': shopAnnounce,
      'shopDetail': shopDetail,
      'shopAddress': shopAddress,
      'shopLat': shopLat,
      'shopLng': shopLng,
      'shopVideo': shopVideo,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      shopId: map['shopId'] as int,
      shopName: map['shopName'] as String,
      shopAnnounce: map['shopAnnounce'] as String,
      shopDetail: map['shopDetail'] as String,
      shopAddress: map['shopAddress'] as String,
      shopLat: map['shopLat'] as double,
      shopLng: map['shopLng'] as double,
      shopVideo: map['shopVideo'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
