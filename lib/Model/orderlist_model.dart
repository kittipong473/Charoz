// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderListModel {
  final int orderId;
  final int orderShopId;
  final int orderCustomerId;
  final int orderRiderId;
  final String orderProductIds;
  final String orderProductAmounts;
  final double orderTotal;
  final String orderPaymentType;
  final String orderReceiveType;
  final String orderStatus;
  final DateTime created;
  final DateTime updated;
  OrderListModel({
    required this.orderId,
    required this.orderShopId,
    required this.orderCustomerId,
    required this.orderRiderId,
    required this.orderProductIds,
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
    int? orderShopId,
    int? orderCustomerId,
    int? orderRiderId,
    String? orderProductIds,
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
      orderShopId: orderShopId ?? this.orderShopId,
      orderCustomerId: orderCustomerId ?? this.orderCustomerId,
      orderRiderId: orderRiderId ?? this.orderRiderId,
      orderProductIds: orderProductIds ?? this.orderProductIds,
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
    return <String, dynamic>{
      'orderId': orderId,
      'orderShopId': orderShopId,
      'orderCustomerId': orderCustomerId,
      'orderRiderId': orderRiderId,
      'orderProductIds': orderProductIds,
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
      orderId: map['orderId'] as int,
      orderShopId: map['orderShopId'] as int,
      orderCustomerId: map['orderCustomerId'] as int,
      orderRiderId: map['orderRiderId'] as int,
      orderProductIds: map['orderProductIds'] as String,
      orderProductAmounts: map['orderProductAmounts'] as String,
      orderTotal: map['orderTotal'] as double,
      orderPaymentType: map['orderPaymentType'] as String,
      orderReceiveType: map['orderReceiveType'] as String,
      orderStatus: map['orderStatus'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderListModel.fromJson(String source) =>
      OrderListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderList(orderId: $orderId, orderShopId: $orderShopId, orderCustomerId: $orderCustomerId, orderRiderId: $orderRiderId, orderProductIds: $orderProductIds, orderProductAmounts: $orderProductAmounts, orderTotal: $orderTotal, orderPaymentType: $orderPaymentType, orderReceiveType: $orderReceiveType, orderStatus: $orderStatus, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderListModel &&
        other.orderId == orderId &&
        other.orderShopId == orderShopId &&
        other.orderCustomerId == orderCustomerId &&
        other.orderRiderId == orderRiderId &&
        other.orderProductIds == orderProductIds &&
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
        orderShopId.hashCode ^
        orderCustomerId.hashCode ^
        orderRiderId.hashCode ^
        orderProductIds.hashCode ^
        orderProductAmounts.hashCode ^
        orderTotal.hashCode ^
        orderPaymentType.hashCode ^
        orderReceiveType.hashCode ^
        orderStatus.hashCode ^
        created.hashCode ^
        updated.hashCode;
  }
}
