import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SubOrderModel {
  final String shopid;
  final String riderid;
  final String customerid;
  final String addressid;
  final String productid;
  final String productamount;
  final int charge;
  final int total;
  final int type;
  final String commentshop;
  final String commentrider;
  final int status;
  final int track;
  final Timestamp time;
  SubOrderModel({
    required this.shopid,
    required this.riderid,
    required this.customerid,
    required this.addressid,
    required this.productid,
    required this.productamount,
    required this.charge,
    required this.total,
    required this.type,
    required this.commentshop,
    required this.commentrider,
    required this.status,
    required this.track,
    required this.time,
  });

  SubOrderModel copyWith({
    String? shopid,
    String? riderid,
    String? customerid,
    String? addressid,
    String? productid,
    String? productamount,
    int? charge,
    int? total,
    int? type,
    String? commentshop,
    String? commentrider,
    int? status,
    int? track,
    Timestamp? time,
  }) {
    return SubOrderModel(
      shopid: shopid ?? this.shopid,
      riderid: riderid ?? this.riderid,
      customerid: customerid ?? this.customerid,
      addressid: addressid ?? this.addressid,
      productid: productid ?? this.productid,
      productamount: productamount ?? this.productamount,
      charge: charge ?? this.charge,
      total: total ?? this.total,
      type: type ?? this.type,
      commentshop: commentshop ?? this.commentshop,
      commentrider: commentrider ?? this.commentrider,
      status: status ?? this.status,
      track: track ?? this.track,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopid': shopid,
      'riderid': riderid,
      'customerid': customerid,
      'addressid': addressid,
      'productid': productid,
      'productamount': productamount,
      'charge': charge,
      'total': total,
      'type': type,
      'commentshop': commentshop,
      'commentrider': commentrider,
      'status': status,
      'track': track,
      'time': time,
    };
  }

  factory SubOrderModel.fromMap(Map<String, dynamic> map) {
    return SubOrderModel(
      shopid: map['shopid'] ?? '',
      riderid: map['riderid'] ?? '',
      customerid: map['customerid'] ?? '',
      addressid: map['addressid'] ?? '',
      productid: map['productid'] ?? '',
      productamount: map['productamount'] ?? '',
      charge: map['charge']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      type: map['type']?.toInt() ?? 0,
      commentshop: map['commentshop'] ?? '',
      commentrider: map['commentrider'] ?? '',
      status: map['status']?.toInt() ?? 0,
      track: map['track']?.toInt() ?? 0,
      time: map['time'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubOrderModel.fromJson(String source) => SubOrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubOrderModel(shopid: $shopid, riderid: $riderid, customerid: $customerid, addressid: $addressid, productid: $productid, productamount: $productamount, charge: $charge, total: $total, type: $type, commentshop: $commentshop, commentrider: $commentrider, status: $status, track: $track, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SubOrderModel &&
      other.shopid == shopid &&
      other.riderid == riderid &&
      other.customerid == customerid &&
      other.addressid == addressid &&
      other.productid == productid &&
      other.productamount == productamount &&
      other.charge == charge &&
      other.total == total &&
      other.type == type &&
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
      charge.hashCode ^
      total.hashCode ^
      type.hashCode ^
      commentshop.hashCode ^
      commentrider.hashCode ^
      status.hashCode ^
      track.hashCode ^
      time.hashCode;
  }
}