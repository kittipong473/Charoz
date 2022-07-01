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
  final String shopImage;
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
    required this.shopImage,
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
    String? shopImage,
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
      shopImage: shopImage ?? this.shopImage,
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
      'shopImage': shopImage,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      shopId: map['shopId']?.toInt() ?? 0,
      shopName: map['shopName'] ?? '',
      shopAnnounce: map['shopAnnounce'] ?? '',
      shopDetail: map['shopDetail'] ?? '',
      shopAddress: map['shopAddress'] ?? '',
      shopLat: map['shopLat']?.toDouble() ?? 0.0,
      shopLng: map['shopLng']?.toDouble() ?? 0.0,
      shopImage: map['shopImage'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) => ShopModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShopModel(shopId: $shopId, shopName: $shopName, shopAnnounce: $shopAnnounce, shopDetail: $shopDetail, shopAddress: $shopAddress, shopLat: $shopLat, shopLng: $shopLng, shopImage: $shopImage, created: $created, updated: $updated)';
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
      other.shopImage == shopImage &&
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
      shopImage.hashCode ^
      created.hashCode ^
      updated.hashCode;
  }
}
