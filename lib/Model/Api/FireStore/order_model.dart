// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? id;
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
  DateTime? time;
  OrderModel({
    this.id,
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

  OrderModel convert({required dynamic item, String? id}) {
    return OrderModel(
      id: id ?? item.id,
      shopid: item['shopid'],
      customerid: item['customerid'],
      riderid: item['riderid'],
      addressid: item['addressid'],
      productid: item['productid'],
      productamount: item['productamount'],
      delivery: item['delivery'],
      total: item['total'],
      commentshop: item['commentshop'],
      commentrider: item['commentrider'],
      status: item['status'],
      track: item['track'],
      time: (item['time'] as Timestamp).toDate(),
    );
  }
}
