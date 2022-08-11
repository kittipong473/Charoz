import 'dart:async';

import 'package:charoz/Model_Main/order_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Database/Firebase/order_crud.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 77.h,
      child: MyVariable.role == 'manager'
          ? orderListManager()
          : MyVariable.role == 'rider'
              ? orderListRider()
              : MyVariable.role == 'customer'
                  ? orderListCustomer()
                  : buildEmptyOrder(),
    );
  }

  StreamBuilder orderListManager() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderManagerListByProcess(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return buildEmptyOrder();
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time.compareTo(a.time));
          return buildOrderList(orderList);
        } else {
          return const ShowProgress();
        }
      },
    );
  }

  StreamBuilder orderListRider() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderRiderListByNotAccept(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return buildEmptyOrder();
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time.compareTo(a.time));
          return buildOrderList(orderList);
        } else {
          return const ShowProgress();
        }
      },
    );
  }

  StreamBuilder orderListCustomer() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderCustomerListByProcess(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return buildEmptyOrder();
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time.compareTo(a.time));
          return buildOrderList(orderList);
        } else {
          return const ShowProgress();
        }
      },
    );
  }

  Widget buildEmptyOrder() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('ยังไม่มี ออเดอร์ ในขณะนี้', style: MyStyle().normalPrimary18()),
          SizedBox(height: 3.h),
          Text('กรุณารอรายการ ออเดอร์ ได้ในภายหลัง',
              style: MyStyle().normalPrimary18()),
        ],
      ),
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
    if (MyVariable.role == 'manager') {
      await Provider.of<UserProvider>(context, listen: false)
          .readCustomerById(order.customerid);
      if (order.riderid != '') {
        await Provider.of<UserProvider>(context, listen: false)
            .readRiderById(order.riderid);
      }
    } else if (MyVariable.role == 'rider') {
      await Provider.of<UserProvider>(context, listen: false)
          .readCustomerById(order.customerid);
      await Provider.of<AddressProvider>(context, listen: false)
          .readAddressById(order.addressid);
    } else if (MyVariable.role == 'customer') {
      if (order.riderid != '') {
        await Provider.of<UserProvider>(context, listen: false)
            .readRiderById(order.riderid);
      }
    }
  }

  Widget buildOrderItem(BuildContext context, OrderModel order, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      color: MyVariable.orderTrackingColor[order.track],
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Provider.of<OrderProvider>(context, listen: false)
              .setOrderModel(order);
          Navigator.pushNamed(context, RoutePage.routeOrderDetail);
        },
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Consumer3<ShopProvider, UserProvider, AddressProvider>(
            builder: (_, sprovider, uprovider, aprovider, __) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(MyVariable.orderStatusList[order.status],
                        style: MyStyle().boldPrimary18()),
                    Text(MyFunction().convertToDateTime(order.time),
                        style: MyStyle().normalBlack14()),
                  ],
                ),
                ScreenWidget().buildSpacer(),
                if (MyVariable.role == 'manager') ...[
                  fragmentManagerDetail(order)
                ] else if (MyVariable.role == 'rider') ...[
                  fragmentRiderDetail(order)
                ] else if (MyVariable.role == 'customer') ...[
                  fragmentCustomerDetail(order)
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fragmentManagerDetail(OrderModel order) {
    return Consumer<UserProvider>(
      builder: (_, uprovider, __) => uprovider.customer == null
          ? const ShowProgress()
          : Column(
              children: [
                fragmentEachRowDetail(Icons.person_rounded, 'ชื่อลูกค้า',
                    '${uprovider.customer.firstname} ${uprovider.customer.lastname}'),
                fragmentEachRowDetail(
                    Icons.food_bank_rounded, 'ประเภท', order.type.toString()),
                fragmentEachRowDetail(
                    Icons.money_rounded, 'ราคา', '${order.total} ฿'),
                if (order.type == 1) ...[
                  fragmentEachRowDetail(
                    Icons.delivery_dining_rounded,
                    'ชื่อคนขับ',
                    order.riderid == ''
                        ? 'ยังไม่มีคนขับรับงาน'
                        : '${uprovider.rider.firstname} ${uprovider.rider.lastname}',
                  ),
                ],
              ],
            ),
    );
  }

  Widget fragmentRiderDetail(OrderModel order) {
    return Consumer3<UserProvider, ShopProvider, AddressProvider>(
      builder: (_, uprovider, sprovider, aprovider, __) =>
          sprovider.shop == null ||
                  uprovider.customer == null ||
                  aprovider.address == null
              ? const ShowProgress()
              : Column(
                  children: [
                    fragmentEachRowDetail(Icons.store_mall_directory_rounded,
                        'ร้านอาหาร', sprovider.shop.name),
                    fragmentEachRowDetail(Icons.person_rounded, 'ชื่อลูกค้า',
                        '${uprovider.customer.firstname} ${uprovider.customer.lastname}'),
                    fragmentEachRowDetail(Icons.location_pin, 'สถานที่จัดส่ง',
                        aprovider.address.name),
                    fragmentEachRowDetail(
                        Icons.money_rounded, 'ราคารวมส่ง', '${order.total} ฿'),
                  ],
                ),
    );
  }

  Widget fragmentCustomerDetail(OrderModel order) {
    return Consumer2<UserProvider, ShopProvider>(
      builder: (_, uprovider, sprovider, __) => sprovider.shop == null
          ? const ShowProgress()
          : Column(
              children: [
                fragmentEachRowDetail(Icons.store_mall_directory_rounded,
                    'ร้านอาหาร', sprovider.shop.name),
                fragmentEachRowDetail(
                    Icons.food_bank_rounded, 'ประเภท', order.type.toString()),
                fragmentEachRowDetail(
                    Icons.money_rounded, 'ราคา', '${order.total} ฿'),
                if (order.type == 0) ...[
                  fragmentEachRowDetail(Icons.location_pin, 'สถานที่รับ',
                      'คอนโดถนอมมิตร ตึก 11 ชั้นล่าง'),
                ] else ...[
                  fragmentEachRowDetail(
                    Icons.delivery_dining_rounded,
                    'ชื่อคนขับ',
                    order.riderid == ''
                        ? 'ยังไม่มีคนขับรับงาน'
                        : '${uprovider.rider.firstname} ${uprovider.rider.lastname}',
                  ),
                ],
              ],
            ),
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
          Text(MyVariable.orderReceiveTypeList[int.parse(detail)],
              style: MyStyle().normalBlack16()),
        ] else ...[
          Text(detail, style: MyStyle().normalBlack16()),
        ],
      ],
    );
  }
}
