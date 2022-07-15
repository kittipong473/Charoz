// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  final int orderId;
  final int shopId;
  final int managerId;
  final int customerId;
  final int riderId;
  final int addressId;
  final String productIds;
  final String orderProductAmounts;
  final double orderTotal;
  final String orderReceiveType;
  final String orderCommentShop;
  final String orderCommentRider;
  final String orderStatus;
  final String orderTracking;
  final DateTime created;
  final DateTime updated;
  OrderModel({
    required this.orderId,
    required this.shopId,
    required this.managerId,
    required this.customerId,
    required this.riderId,
    required this.addressId,
    required this.productIds,
    required this.orderProductAmounts,
    required this.orderTotal,
    required this.orderReceiveType,
    required this.orderCommentShop,
    required this.orderCommentRider,
    required this.orderStatus,
    required this.orderTracking,
    required this.created,
    required this.updated,
  });

  OrderModel copyWith({
    int? orderId,
    int? shopId,
    int? managerId,
    int? customerId,
    int? riderId,
    int? addressId,
    String? productIds,
    String? orderProductAmounts,
    double? orderTotal,
    String? orderReceiveType,
    String? orderCommentShop,
    String? orderCommentRider,
    String? orderStatus,
    String? orderTracking,
    DateTime? created,
    DateTime? updated,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      shopId: shopId ?? this.shopId,
      managerId: managerId ?? this.managerId,
      customerId: customerId ?? this.customerId,
      riderId: riderId ?? this.riderId,
      addressId: addressId ?? this.addressId,
      productIds: productIds ?? this.productIds,
      orderProductAmounts: orderProductAmounts ?? this.orderProductAmounts,
      orderTotal: orderTotal ?? this.orderTotal,
      orderReceiveType: orderReceiveType ?? this.orderReceiveType,
      orderCommentShop: orderCommentShop ?? this.orderCommentShop,
      orderCommentRider: orderCommentRider ?? this.orderCommentRider,
      orderStatus: orderStatus ?? this.orderStatus,
      orderTracking: orderTracking ?? this.orderTracking,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'shopId': shopId,
      'managerId': managerId,
      'customerId': customerId,
      'riderId': riderId,
      'addressId': addressId,
      'productIds': productIds,
      'orderProductAmounts': orderProductAmounts,
      'orderTotal': orderTotal,
      'orderReceiveType': orderReceiveType,
      'orderCommentShop': orderCommentShop,
      'orderCommentRider': orderCommentRider,
      'orderStatus': orderStatus,
      'orderTracking': orderTracking,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId']?.toInt() ?? 0,
      shopId: map['shopId']?.toInt() ?? 0,
      managerId: map['managerId']?.toInt() ?? 0,
      customerId: map['customerId']?.toInt() ?? 0,
      riderId: map['riderId']?.toInt() ?? 0,
      addressId: map['addressId']?.toInt() ?? 0,
      productIds: map['productIds'] ?? '',
      orderProductAmounts: map['orderProductAmounts'] ?? '',
      orderTotal: map['orderTotal']?.toDouble() ?? 0.0,
      orderReceiveType: map['orderReceiveType'] ?? '',
      orderCommentShop: map['orderCommentShop'] ?? '',
      orderCommentRider: map['orderCommentRider'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      orderTracking: map['orderTracking'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, shopId: $shopId, managerId: $managerId, customerId: $customerId, riderId: $riderId, addressId: $addressId, productIds: $productIds, orderProductAmounts: $orderProductAmounts, orderTotal: $orderTotal, orderReceiveType: $orderReceiveType, orderCommentShop: $orderCommentShop, orderCommentRider: $orderCommentRider, orderStatus: $orderStatus, orderTracking: $orderTracking, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.orderId == orderId &&
        other.shopId == shopId &&
        other.managerId == managerId &&
        other.customerId == customerId &&
        other.riderId == riderId &&
        other.addressId == addressId &&
        other.productIds == productIds &&
        other.orderProductAmounts == orderProductAmounts &&
        other.orderTotal == orderTotal &&
        other.orderReceiveType == orderReceiveType &&
        other.orderCommentShop == orderCommentShop &&
        other.orderCommentRider == orderCommentRider &&
        other.orderStatus == orderStatus &&
        other.orderTracking == orderTracking &&
        other.created == created &&
        other.updated == updated;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        shopId.hashCode ^
        managerId.hashCode ^
        customerId.hashCode ^
        riderId.hashCode ^
        addressId.hashCode ^
        productIds.hashCode ^
        orderProductAmounts.hashCode ^
        orderTotal.hashCode ^
        orderReceiveType.hashCode ^
        orderCommentShop.hashCode ^
        orderCommentRider.hashCode ^
        orderStatus.hashCode ^
        orderTracking.hashCode ^
        created.hashCode ^
        updated.hashCode;
  }
}

OrderModel convertOrder(dynamic item) {
  return OrderModel(
    orderId: int.parse(item['orderId']),
    shopId: int.parse(item['shopId']),
    managerId: int.parse(item['managerId']),
    customerId: int.parse(item['customerId']),
    riderId: int.parse(item['riderId']),
    addressId: int.parse(item['addressId']),
    productIds: item['productIds'],
    orderProductAmounts: item['orderProductAmounts'],
    orderTotal: double.parse(item['orderTotal']),
    orderReceiveType: item['orderReceiveType'],
    orderCommentShop: item['orderCommentShop'],
    orderCommentRider: item['orderCommentRider'],
    orderStatus: item['orderStatus'],
    orderTracking: item['orderTracking'],
    created: DateTime.parse(item['created']),
    updated: DateTime.parse(item['updated']),
  );
}
