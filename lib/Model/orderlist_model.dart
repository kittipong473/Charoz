// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderListModel {
  final int orderId;
  final int shopId;
  final int customerId;
  final int riderId;
  final String productIds;
  final String orderProductAmounts;
  final double orderTotal;
  final String orderPaymentType;
  final String orderReceiveType;
  final String orderStatus;
  final DateTime created;
  final DateTime updated;
  OrderListModel({
    required this.orderId,
    required this.shopId,
    required this.customerId,
    required this.riderId,
    required this.productIds,
    required this.orderProductAmounts,
    required this.orderTotal,
    required this.orderPaymentType,
    required this.orderReceiveType,
    required this.orderStatus,
    required this.created,
    required this.updated,
  });

  OrderListModel copyWith({
    int? orderId,
    int? shopId,
    int? customerId,
    int? riderId,
    String? productIds,
    String? orderProductAmounts,
    double? orderTotal,
    String? orderPaymentType,
    String? orderReceiveType,
    String? orderStatus,
    DateTime? created,
    DateTime? updated,
  }) {
    return OrderListModel(
      orderId: orderId ?? this.orderId,
      shopId: shopId ?? this.shopId,
      customerId: customerId ?? this.customerId,
      riderId: riderId ?? this.riderId,
      productIds: productIds ?? this.productIds,
      orderProductAmounts: orderProductAmounts ?? this.orderProductAmounts,
      orderTotal: orderTotal ?? this.orderTotal,
      orderPaymentType: orderPaymentType ?? this.orderPaymentType,
      orderReceiveType: orderReceiveType ?? this.orderReceiveType,
      orderStatus: orderStatus ?? this.orderStatus,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'shopId': shopId,
      'customerId': customerId,
      'riderId': riderId,
      'productIds': productIds,
      'orderProductAmounts': orderProductAmounts,
      'orderTotal': orderTotal,
      'orderPaymentType': orderPaymentType,
      'orderReceiveType': orderReceiveType,
      'orderStatus': orderStatus,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory OrderListModel.fromMap(Map<String, dynamic> map) {
    return OrderListModel(
      orderId: map['orderId']?.toInt() ?? 0,
      shopId: map['shopId']?.toInt() ?? 0,
      customerId: map['customerId']?.toInt() ?? 0,
      riderId: map['riderId']?.toInt() ?? 0,
      productIds: map['productIds'] ?? '',
      orderProductAmounts: map['orderProductAmounts'] ?? '',
      orderTotal: map['orderTotal']?.toDouble() ?? 0.0,
      orderPaymentType: map['orderPaymentType'] ?? '',
      orderReceiveType: map['orderReceiveType'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderListModel.fromJson(String source) => OrderListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderListModel(orderId: $orderId, shopId: $shopId, customerId: $customerId, riderId: $riderId, productIds: $productIds, orderProductAmounts: $orderProductAmounts, orderTotal: $orderTotal, orderPaymentType: $orderPaymentType, orderReceiveType: $orderReceiveType, orderStatus: $orderStatus, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderListModel &&
      other.orderId == orderId &&
      other.shopId == shopId &&
      other.customerId == customerId &&
      other.riderId == riderId &&
      other.productIds == productIds &&
      other.orderProductAmounts == orderProductAmounts &&
      other.orderTotal == orderTotal &&
      other.orderPaymentType == orderPaymentType &&
      other.orderReceiveType == orderReceiveType &&
      other.orderStatus == orderStatus &&
      other.created == created &&
      other.updated == updated;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
      shopId.hashCode ^
      customerId.hashCode ^
      riderId.hashCode ^
      productIds.hashCode ^
      orderProductAmounts.hashCode ^
      orderTotal.hashCode ^
      orderPaymentType.hashCode ^
      orderReceiveType.hashCode ^
      orderStatus.hashCode ^
      created.hashCode ^
      updated.hashCode;
  }
}
