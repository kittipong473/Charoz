// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRequest {
  String? shopid;
  String? riderid;
  String? customerid;
  String? addressid;
  String? productid;
  String? productamount;
  bool? delivery;
  int? total;
  String? commentshop;
  String? commentrider;
  int? status;
  int? track;
  Timestamp? time;
  OrderRequest({
    this.shopid,
    this.riderid,
    this.customerid,
    this.addressid,
    this.productid,
    this.productamount,
    this.delivery,
    this.total,
    this.commentshop,
    this.commentrider,
    this.status,
    this.track,
    this.time,
  });

  OrderRequest copyWith({
    String? shopid,
    String? riderid,
    String? customerid,
    String? addressid,
    String? productid,
    String? productamount,
    bool? delivery,
    int? total,
    String? commentshop,
    String? commentrider,
    int? status,
    int? track,
    Timestamp? time,
  }) {
    return OrderRequest(
      shopid: shopid ?? this.shopid,
      riderid: riderid ?? this.riderid,
      customerid: customerid ?? this.customerid,
      addressid: addressid ?? this.addressid,
      productid: productid ?? this.productid,
      productamount: productamount ?? this.productamount,
      delivery: delivery ?? this.delivery,
      total: total ?? this.total,
      commentshop: commentshop ?? this.commentshop,
      commentrider: commentrider ?? this.commentrider,
      status: status ?? this.status,
      track: track ?? this.track,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopid': shopid,
      'riderid': riderid,
      'customerid': customerid,
      'addressid': addressid,
      'productid': productid,
      'productamount': productamount,
      'delivery': delivery,
      'total': total,
      'commentshop': commentshop,
      'commentrider': commentrider,
      'status': status,
      'track': track,
      'time': time,
    };
  }

  factory OrderRequest.fromMap(Map<String, dynamic> map) {
    return OrderRequest(
      shopid: map['shopid'] != null ? map['shopid'] as String : null,
      riderid: map['riderid'] != null ? map['riderid'] as String : null,
      customerid:
          map['customerid'] != null ? map['customerid'] as String : null,
      addressid: map['addressid'] != null ? map['addressid'] as String : null,
      productid: map['productid'] != null ? map['productid'] as String : null,
      productamount:
          map['productamount'] != null ? map['productamount'] as String : null,
      delivery: map['delivery'] != null ? map['delivery'] as bool : null,
      total: map['total'] != null ? map['total'] as int : null,
      commentshop:
          map['commentshop'] != null ? map['commentshop'] as String : null,
      commentrider:
          map['commentrider'] != null ? map['commentrider'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      track: map['track'] != null ? map['track'] as int : null,
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderRequest.fromJson(String source) =>
      OrderRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderRequest(shopid: $shopid, riderid: $riderid, customerid: $customerid, addressid: $addressid, productid: $productid, productamount: $productamount, delivery: $delivery, total: $total, commentshop: $commentshop, commentrider: $commentrider, status: $status, track: $track, time: $time)';
  }

  @override
  bool operator ==(covariant OrderRequest other) {
    if (identical(this, other)) return true;

    return other.shopid == shopid &&
        other.riderid == riderid &&
        other.customerid == customerid &&
        other.addressid == addressid &&
        other.productid == productid &&
        other.productamount == productamount &&
        other.delivery == delivery &&
        other.total == total &&
        other.commentshop == commentshop &&
        other.commentrider == commentrider &&
        other.status == status &&
        other.track == track &&
        other.time == time;
  }

  @override
  int get hashCode {
    return shopid.hashCode ^
        riderid.hashCode ^
        customerid.hashCode ^
        addressid.hashCode ^
        productid.hashCode ^
        productamount.hashCode ^
        delivery.hashCode ^
        total.hashCode ^
        commentshop.hashCode ^
        commentrider.hashCode ^
        status.hashCode ^
        track.hashCode ^
        time.hashCode;
  }
}
