import 'dart:convert';

class ProductModel {
  final String productId;
  final String productName;
  final String productType;
  final String productPrice;
  final String productDetail;
  final String productImage;
  final String productScore;
  final String productStatus;
  final String productSuggest;
  final String created;
  final String updated;
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
    String? productId,
    String? productName,
    String? productType,
    String? productPrice,
    String? productDetail,
    String? productImage,
    String? productScore,
    String? productStatus,
    String? productSuggest,
    String? created,
    String? updated,
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
    return {
      'productId': productId,
      'productName': productName,
      'productType': productType,
      'productPrice': productPrice,
      'productDetail': productDetail,
      'productImage': productImage,
      'productScore': productScore,
      'productStatus': productStatus,
      'productSuggest': productSuggest,
      'created': created,
      'updated': updated,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      productType: map['productType'] ?? '',
      productPrice: map['productPrice'] ?? '',
      productDetail: map['productDetail'] ?? '',
      productImage: map['productImage'] ?? '',
      productScore: map['productScore'] ?? '',
      productStatus: map['productStatus'] ?? '',
      productSuggest: map['productSuggest'] ?? '',
      created: map['created'] ?? '',
      updated: map['updated'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

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

    static ProductModel fromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'],
      productName: json['productName'],
      productType: json['productType'],
      productPrice: json['productPrice'],
      productDetail: json['productDetail'],
      productImage: json['productImage'],
      productScore: json['productScore'],
      productStatus: json['productStatus'],
      productSuggest: json['productSuggest'],
      created: json['created'],
      updated: json['updated']);
}
