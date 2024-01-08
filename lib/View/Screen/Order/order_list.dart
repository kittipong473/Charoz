import 'dart:async';

import 'package:charoz/Model/Api/FireStore/order_model.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Firebase/order_crud.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final orderVM = Get.find<OrderViewModel>();
  final userVM = Get.find<UserViewModel>();
  final addVM = Get.find<AddressViewModel>();
  final shopVM = Get.find<ShopViewModel>();
  int indexChip = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    if (userVM.role == 4) {
      orderVM.readOrderAdminListByFinish();
    } else if (userVM.role == 3) {
      orderVM.readOrderManagerListByFinish();
    } else if (userVM.role == 2) {
      orderVM.readOrderRiderListByFinish();
    } else {
      orderVM.readOrderCustomerListByFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: Column(
          children: [
            if (userVM.role == 4) ...[
              buildHistoryList(),
            ] else ...[
              buildChip(),
              if (indexChip == 0) ...[
                SizedBox(
                  width: 100.w,
                  height: 77.h,
                  child: userVM.role == 3
                      ? managerOrder()
                      : userVM.role == 2
                          ? riderOrder()
                          : userVM.role == 1
                              ? customerOrder()
                              : MyWidget().showEmptyData(
                                  title: 'ยังไม่มี รายการอาหาร ที่สั่ง',
                                  body:
                                      'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
                                ),
                ),
              ] else ...[
                buildHistoryList(),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget buildChip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < orderVM.orderTypeList.length; i++) ...[
            chip(orderVM.orderTypeList[i], i),
          ],
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      backgroundColor:
          indexChip == index ? MyStyle.orangePrimary : Colors.grey.shade100,
      label: Text(
        userVM.role == 2 && index == 0 ? 'รายการจากลูกค้า' : title,
        style: indexChip == index
            ? MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)
            : MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
      ),
      onPressed: () {
        setState(() => indexChip = index);
        if (index == 1) getData();
      },
    );
  }

  StreamBuilder managerOrder() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderManagerListByProcess(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MyWidget().showEmptyData(
            title: 'ยังไม่มี รายการอาหาร ที่สั่ง',
            body: 'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
          );
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time!.compareTo(a.time!));
          return orderList.isEmpty
              ? MyWidget().showEmptyData(
                  title: 'ยังไม่มี รายการอาหาร ที่สั่ง',
                  body: 'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
                )
              : buildOrderList(orderList);
        } else {
          return MyWidget().showProgress();
        }
      },
    );
  }

  StreamBuilder riderOrder() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderRiderListByNotAccept(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MyWidget().showEmptyData(
            title: 'ยังไม่มี รายการอาหาร ที่สั่ง',
            body: 'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
          );
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time!.compareTo(a.time!));
          return orderList.isEmpty
              ? MyWidget().showEmptyData(
                  title: 'ยังไม่มี รายการอาหาร ที่สั่ง',
                  body: 'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
                )
              : buildOrderList(orderList);
        } else {
          return MyWidget().showProgress();
        }
      },
    );
  }

  StreamBuilder customerOrder() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderCustomerListByProcess(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MyWidget().showEmptyData(
            title: 'ยังไม่มี รายการอาหาร ที่สั่ง',
            body: 'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
          );
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time!.compareTo(a.time!));
          return orderList.isEmpty
              ? MyWidget().showEmptyData(
                  title: 'ยังไม่มี รายการอาหาร ที่สั่ง',
                  body: 'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
                )
              : buildOrderList(orderList);
        } else {
          return MyWidget().showProgress();
        }
      },
    );
  }

  Widget buildOrderList(List<OrderModel> orderList) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0),
      itemCount: orderList.length,
      itemBuilder: (context, index) {
        getDetailOrderByRole(orderList[index]);
        return buildOrderItem(orderList[index], index);
      },
    );
  }

  Future getDetailOrderByRole(OrderModel order) async {
    if (userVM.role == 3) {
      await userVM.readCustomerById(order.customerid!);
      if (order.riderid != '') {
        await userVM.readRiderById(order.riderid!);
      }
    } else if (userVM.role == 2) {
      await userVM.readCustomerById(order.customerid!);
      await addVM.readAddressById(order.addressid!);
    } else if (userVM.role == 1) {
      if (order.riderid != '') {
        await userVM.readRiderById(order.riderid!);
      }
    } else if (userVM.role == 4) {
      await userVM.readCustomerById(order.customerid!);
      if (order.delivery!) {
        await addVM.readAddressById(order.addressid!);
      }
      if (order.riderid != '') {
        await userVM.readRiderById(order.riderid!);
      }
    }
  }

  Widget buildOrderItem(OrderModel order, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      color: orderVM.orderTrackingColor[order.track!],
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          orderVM.setOrderModel(order);
          Get.toNamed(RoutePage.routeOrderDetail);
        },
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(orderVM.datatypeOrderStatus[order.status!],
                      style: MyStyle.textStyle(
                          size: 16, color: MyStyle.orangePrimary)),
                  Text(MyFunction().convertToDateTime(time: order.time!),
                      style: MyStyle.textStyle(
                          size: 14, color: MyStyle.blackPrimary)),
                ],
              ),
              MyWidget().buildSpacer(),
              if (userVM.role == 3) ...[
                fragmentManagerDetail(order)
              ] else if (userVM.role == 2) ...[
                fragmentRiderDetail(order)
              ] else if (userVM.role == 1) ...[
                fragmentCustomerDetail(order)
              ] else if (userVM.role == 4) ...[
                fragmentAdminDetail(order)
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget fragmentManagerDetail(OrderModel order) {
    return Column(
      children: [
        fragmentEachRowDetail(Icons.person_rounded, 'ชื่อลูกค้า',
            '${userVM.customer!.firstname} ${userVM.customer!.lastname}'),
        fragmentEachRowDetail(
            Icons.food_bank_rounded, 'ประเภท', order.delivery.toString()),
        fragmentEachRowDetail(Icons.money_rounded, 'ราคา', '${order.total} ฿'),
        if (order.delivery!) ...[
          fragmentEachRowDetail(
            Icons.delivery_dining_rounded,
            'ชื่อคนขับ',
            order.riderid == ''
                ? 'ยังไม่มีคนขับรับงาน'
                : userVM.rider == null
                    ? ''
                    : '${userVM.rider!.firstname} ${userVM.rider!.lastname}',
          ),
        ],
      ],
    );
  }

  Widget fragmentRiderDetail(OrderModel order) {
    return Column(
      children: [
        fragmentEachRowDetail(
            Icons.store_mall_directory_rounded, 'ร้านอาหาร', shopVM.shop.name),
        fragmentEachRowDetail(Icons.person_rounded, 'ชื่อลูกค้า',
            '${userVM.customer!.firstname} ${userVM.customer!.lastname}'),
        fragmentEachRowDetail(Icons.location_pin, 'สถานที่จัดส่ง',
            addVM.address!.type!.toString()),
        fragmentEachRowDetail(
            Icons.money_rounded, 'ราคารวมส่ง', '${order.total} ฿'),
      ],
    );
  }

  Widget fragmentCustomerDetail(OrderModel order) {
    return Column(
      children: [
        fragmentEachRowDetail(
            Icons.store_mall_directory_rounded, 'ร้านอาหาร', shopVM.shop.name),
        fragmentEachRowDetail(
            Icons.food_bank_rounded, 'ประเภท', order.delivery.toString()),
        fragmentEachRowDetail(Icons.money_rounded, 'ราคา', '${order.total} ฿'),
        if (order.delivery!) ...[
          fragmentEachRowDetail(Icons.location_pin, 'สถานที่รับ',
              'คอนโดถนอมมิตร ตึก 11 ชั้นล่าง'),
        ] else ...[
          fragmentEachRowDetail(
            Icons.delivery_dining_rounded,
            'ชื่อคนขับ',
            order.riderid == ''
                ? 'ยังไม่มีคนขับรับงาน'
                : userVM.rider == null
                    ? ''
                    : '${userVM.rider!.firstname} ${userVM.rider!.lastname}',
          ),
        ],
      ],
    );
  }

  Widget fragmentAdminDetail(OrderModel order) {
    return Column(
      children: [
        fragmentEachRowDetail(
            Icons.food_bank_rounded, 'ประเภท', order.delivery.toString()),
        fragmentEachRowDetail(
            Icons.person_rounded,
            'ชื่อลูกค้า',
            userVM.customer == null
                ? ''
                : '${userVM.customer!.firstname} ${userVM.customer!.lastname}'),
        if (order.delivery!) ...[
          fragmentEachRowDetail(
            Icons.delivery_dining_rounded,
            'ชื่อคนขับ',
            order.riderid == ''
                ? 'ยังไม่มีคนขับรับงาน'
                : userVM.rider == null
                    ? ''
                    : '${userVM.rider!.firstname} ${userVM.rider!.lastname}',
          ),
          fragmentEachRowDetail(Icons.location_pin, 'สถานที่จัดส่ง',
              addVM.address == null ? '' : addVM.address!.type.toString()),
        ],
        fragmentEachRowDetail(Icons.money_rounded, 'ราคา', '${order.total} ฿'),
      ],
    );
  }

  Widget fragmentEachRowDetail(IconData icon, String title, String detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 20.sp, color: MyStyle.bluePrimary),
            SizedBox(width: 2.w),
            Text('$title : ',
                style: MyStyle.textStyle(size: 16, color: MyStyle.bluePrimary)),
          ],
        ),
        if (title == 'ประเภท') ...[
          Text(orderVM.orderReceiveList[int.parse(detail)],
              style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
        ] else ...[
          Text(detail,
              style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
        ],
      ],
    );
  }

  Widget buildHistoryList() {
    return SizedBox(
      width: 100.w,
      height: 77.h,
      child: orderVM.orderList.isEmpty
          ? MyWidget().showEmptyData(
              title: 'ไม่มีประวัติรายการอาหารของคุณ',
              body:
                  'จะมีข้อมูลรายการอาหาร เมื่อมีการสั่งอาหารแล้วทำรายการสำเร็จ')
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 1.h),
              itemCount: orderVM.orderList.length,
              itemBuilder: (context, index) {
                getDetailOrderByRole(orderVM.orderList[index]);
                return buildOrderItem(orderVM.orderList[index], index);
              },
            ),
    );
  }
}
