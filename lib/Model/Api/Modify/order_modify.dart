// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModify {
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
  OrderModify({
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
}
