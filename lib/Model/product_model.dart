// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final int productId;
  final String productName;
  final String productType;
  final double productPrice;
  final String productDetail;
  final String productImage;
  final double productScore;
  final int productStatus;
  final int productSuggest;
  final DateTime created;
  final DateTime updated;
  ProductModel({
    required this.productId,
    required this.productName,
    required this.productType,
    required this.productPrice,
    required this.productDetail,
    required this.productImage,
    required this.productScore,
    required this.productStatus,
    required this.productSuggest,
    required this.created,
    required this.updated,
  });

  ProductModel copyWith({
    int? productId,
    String? productName,
    String? productType,
    double? productPrice,
    String? productDetail,
    String? productImage,
    double? productScore,
    int? productStatus,
    int? productSuggest,
    DateTime? created,
    DateTime? updated,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productType: productType ?? this.productType,
      productPrice: productPrice ?? this.productPrice,
      productDetail: productDetail ?? this.productDetail,
      productImage: productImage ?? this.productImage,
      productScore: productScore ?? this.productScore,
      productStatus: productStatus ?? this.productStatus,
      productSuggest: productSuggest ?? this.productSuggest,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'productType': productType,
      'productPrice': productPrice,
      'productDetail': productDetail,
      'productImage': productImage,
      'productScore': productScore,
      'productStatus': productStatus,
      'productSuggest': productSuggest,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] as int,
      productName: map['productName'] as String,
      productType: map['productType'] as String,
      productPrice: map['productPrice'] as double,
      productDetail: map['productDetail'] as String,
      productImage: map['productImage'] as String,
      productScore: map['productScore'] as double,
      productStatus: map['productStatus'] as int,
      productSuggest: map['productSuggest'] as int,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(productId: $productId, productName: $productName, productType: $productType, productPrice: $productPrice, productDetail: $productDetail, productImage: $productImage, productScore: $productScore, productStatus: $productStatus, productSuggest: $productSuggest, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.productId == productId &&
        other.productName == productName &&
        other.productType == productType &&
        other.productPrice == productPrice &&
        other.productDetail == productDetail &&
        other.productImage == productImage &&
        other.productScore == productScore &&
        other.productStatus == productStatus &&
        other.productSuggest == productSuggest &&
        other.created == created &&
        other.updated == updated;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        productType.hashCode ^
        productPrice.hashCode ^
        productDetail.hashCode ^
        productImage.hashCode ^
        productScore.hashCode ^
        productStatus.hashCode ^
        productSuggest.hashCode ^
        created.hashCode ^
        updated.hashCode;
  }
}
