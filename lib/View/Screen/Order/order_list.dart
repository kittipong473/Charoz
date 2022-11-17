import 'dart:async';

import 'package:charoz/Model/Data/order_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/order_crud.dart';
import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_progress.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final OrderViewModel orderVM = Get.find<OrderViewModel>();
final UserViewModel userVM = Get.find<UserViewModel>();
final AddressViewModel addVM = Get.find<AddressViewModel>();
final ShopViewModel shopVM = Get.find<ShopViewModel>();

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  void getData(BuildContext context) {
    if (VariableGeneral.role == 'admin') {
      orderVM.readOrderAdminListByFinish();
    } else if (VariableGeneral.role == 'manager') {
      orderVM.readOrderManagerListByFinish();
    } else if (VariableGeneral.role == 'rider') {
      orderVM.readOrderRiderListByFinish();
    } else {
      orderVM.readOrderCustomerListByFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              top: 2.h,
              child: StatefulBuilder(
                builder: (_, setState) => Column(
                  children: [
                    if (VariableGeneral.role == 'admin') ...[
                      buildHistoryList(),
                    ] else ...[
                      buildChip(context, setState),
                      if (VariableGeneral.indexOrderChip == 0) ...[
                        SizedBox(
                          width: 100.w,
                          height: 77.h,
                          child: VariableGeneral.role == 'manager'
                              ? managerOrder()
                              : VariableGeneral.role == 'rider'
                                  ? riderOrder()
                                  : VariableGeneral.role == 'customer'
                                      ? customerOrder()
                                      : ScreenWidget().showEmptyData(
                                          'ยังไม่มี รายการอาหาร ที่สั่ง',
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChip(BuildContext context, Function setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < VariableData.orderTypeList.length; i++) ...[
            chip(context, setState, VariableData.orderTypeList[i], i),
          ],
        ],
      ),
    );
  }

  Widget chip(
      BuildContext context, Function setState, String title, int index) {
    return ActionChip(
      backgroundColor: VariableGeneral.indexOrderChip == index
          ? MyStyle.primary
          : Colors.grey.shade100,
      label: Text(
        VariableGeneral.role == 'rider' && index == 0
            ? 'รายการจากลูกค้า'
            : title,
        style: VariableGeneral.indexOrderChip == index
            ? MyStyle().normalWhite16()
            : MyStyle().normalBlack16(),
      ),
      onPressed: () {
        setState(() => VariableGeneral.indexOrderChip = index);
        if (index == 1) {
          getData(context);
        }
      },
    );
  }

  StreamBuilder managerOrder() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderManagerListByProcess(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ScreenWidget().showEmptyData(
            'ยังไม่มี รายการอาหาร ที่สั่ง',
            'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
          );
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time.compareTo(a.time));
          return orderList.isEmpty
              ? ScreenWidget().showEmptyData(
                  'ยังไม่มี รายการอาหาร ที่สั่ง',
                  'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
                )
              : buildOrderList(orderList);
        } else {
          return const ShowProgress();
        }
      },
    );
  }

  StreamBuilder riderOrder() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderRiderListByNotAccept(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ScreenWidget().showEmptyData(
            'ยังไม่มี รายการอาหาร ที่สั่ง',
            'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
          );
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time.compareTo(a.time));
          return orderList.isEmpty
              ? ScreenWidget().showEmptyData(
                  'ยังไม่มี รายการอาหาร ที่สั่ง',
                  'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
                )
              : buildOrderList(orderList);
        } else {
          return const ShowProgress();
        }
      },
    );
  }

  StreamBuilder customerOrder() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderCustomerListByProcess(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ScreenWidget().showEmptyData(
            'ยังไม่มี รายการอาหาร ที่สั่ง',
            'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
          );
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time.compareTo(a.time));
          return orderList.isEmpty
              ? ScreenWidget().showEmptyData(
                  'ยังไม่มี รายการอาหาร ที่สั่ง',
                  'กรุณารอรายการอาหาร จากลูกค้าได้ในภายหลัง',
                )
              : buildOrderList(orderList);
        } else {
          return const ShowProgress();
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
        getDetailOrderByRole(context, orderList[index]);
        return buildOrderItem(context, orderList[index], index);
      },
    );
  }

  Future getDetailOrderByRole(BuildContext context, OrderModel order) async {
    if (VariableGeneral.role == 'manager') {
      await userVM.readCustomerById(order.customerid);
      if (order.riderid != '') {
        await userVM.readRiderById(order.riderid);
      }
    } else if (VariableGeneral.role == 'rider') {
      await userVM.readCustomerById(order.customerid);
      await addVM.readAddressById(order.addressid);
    } else if (VariableGeneral.role == 'customer') {
      if (order.riderid != '') {
        await userVM.readRiderById(order.riderid);
      }
    } else if (VariableGeneral.role == 'admin') {
      await userVM.readCustomerById(order.customerid);
      if (order.type == 1) {
        await addVM.readAddressById(order.addressid);
      }
      if (order.riderid != '') {
        await userVM.readRiderById(order.riderid);
      }
    }
  }

  Widget buildOrderItem(BuildContext context, OrderModel order, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      color: VariableData.orderTrackingColor[order.track],
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          orderVM.setOrderModel(order);
          Navigator.pushNamed(context, RoutePage.routeOrderDetail);
        },
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(VariableData.orderStatusList[order.status],
                      style: MyStyle().boldPrimary18()),
                  Text(MyFunction().convertToDateTime(order.time),
                      style: MyStyle().normalBlack14()),
                ],
              ),
              ScreenWidget().buildSpacer(),
              if (VariableGeneral.role == 'manager') ...[
                fragmentManagerDetail(order)
              ] else if (VariableGeneral.role == 'rider') ...[
                fragmentRiderDetail(order)
              ] else if (VariableGeneral.role == 'customer') ...[
                fragmentCustomerDetail(order)
              ] else if (VariableGeneral.role == 'admin') ...[
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
            '${userVM.customer.firstname} ${userVM.customer.lastname}'),
        fragmentEachRowDetail(
            Icons.food_bank_rounded, 'ประเภท', order.type.toString()),
        fragmentEachRowDetail(Icons.money_rounded, 'ราคา', '${order.total} ฿'),
        if (order.type == 1) ...[
          fragmentEachRowDetail(
            Icons.delivery_dining_rounded,
            'ชื่อคนขับ',
            order.riderid == ''
                ? 'ยังไม่มีคนขับรับงาน'
                : userVM.rider == null
                    ? ''
                    : '${userVM.rider.firstname} ${userVM.rider.lastname}',
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
            '${userVM.customer.firstname} ${userVM.customer.lastname}'),
        fragmentEachRowDetail(
            Icons.location_pin, 'สถานที่จัดส่ง', addVM.address.name),
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
            Icons.food_bank_rounded, 'ประเภท', order.type.toString()),
        fragmentEachRowDetail(Icons.money_rounded, 'ราคา', '${order.total} ฿'),
        if (order.type == 0) ...[
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
                    : '${userVM.rider.firstname} ${userVM.rider.lastname}',
          ),
        ],
      ],
    );
  }

  Widget fragmentAdminDetail(OrderModel order) {
    return Column(
      children: [
        fragmentEachRowDetail(
            Icons.food_bank_rounded, 'ประเภท', order.type.toString()),
        fragmentEachRowDetail(
            Icons.person_rounded,
            'ชื่อลูกค้า',
            userVM.customer == null
                ? ''
                : '${userVM.customer.firstname} ${userVM.customer.lastname}'),
        if (order.type == 1) ...[
          fragmentEachRowDetail(
            Icons.delivery_dining_rounded,
            'ชื่อคนขับ',
            order.riderid == ''
                ? 'ยังไม่มีคนขับรับงาน'
                : userVM.rider == null
                    ? ''
                    : '${userVM.rider.firstname} ${userVM.rider.lastname}',
          ),
          fragmentEachRowDetail(Icons.location_pin, 'สถานที่จัดส่ง',
              addVM.address == null ? '' : addVM.address.type),
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
            Text('$title : ', style: MyStyle().boldBlue16()),
          ],
        ),
        if (title == 'ประเภท') ...[
          Text(VariableData.orderReceiveList[int.parse(detail)],
              style: MyStyle().normalBlack16()),
        ] else ...[
          Text(detail, style: MyStyle().normalBlack16()),
        ],
      ],
    );
  }

  Widget buildHistoryList() {
    return SizedBox(
      width: 100.w,
      height: 77.h,
      child: orderVM.orderList.isEmpty
          ? ScreenWidget().showEmptyData('ไม่มีประวัติรายการอาหารของคุณ',
              'จะมีข้อมูลรายการอาหาร เมื่อมีการสั่งอาหารแล้วทำรายการสำเร็จ')
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 1.h),
              itemCount: orderVM.orderList.length,
              itemBuilder: (context, index) {
                getDetailOrderByRole(context, orderVM.orderList[index]);
                return buildOrderItem(
                    context, orderVM.orderList[index], index);
              },
            ),
    );
  }
}
