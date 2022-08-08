import 'dart:async';

import 'package:charoz/Model/order_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
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

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<String> statusList = [];
  String? role;

  @override
  void initState() {
    super.initState();
    role = MyVariable.role;
    getData();
  }

  Future getData() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .readProductAllList();
    if (role == 'manager') {
      await Provider.of<OrderProvider>(context, listen: false)
          .readOrderManagerListByProcess();
    } else if (role == 'rider') {
      await Provider.of<OrderProvider>(context, listen: false)
          .readOrderRiderListByNotAccept();
    } else if (role == 'customer') {
      await Provider.of<OrderProvider>(context, listen: false)
          .readOrderCustomerList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 77.h,
      child: RefreshIndicator(
        onRefresh: getData,
        child: Consumer<OrderProvider>(
          builder: (_, oprovider, __) => oprovider.orderList == null
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ยังไม่มี ออเดอร์ ในขณะนี้',
                          style: MyStyle().normalPrimary18()),
                      SizedBox(height: 3.h),
                      Text('กรุณารอรายการ ออเดอร์ ได้ในภายหลัง',
                          style: MyStyle().normalPrimary18()),
                    ],
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: oprovider.orderList.length,
                  itemBuilder: (context, index) {
                    getDetailOrderByRole(oprovider.orderList[index]);
                    return buildOrderItem(oprovider.orderList[index], index);
                  },
                ),
        ),
      ),
    );
  }

  Future getDetailOrderByRole(OrderModel order) async {
    if (role == 'manager') {
      await Provider.of<UserProvider>(context, listen: false)
          .readCustomerById(order.id);
      if (order.riderid != '') {
        await Provider.of<UserProvider>(context, listen: false)
            .readRiderById(order.riderid);
      }
    } else if (role == 'rider') {
      await Provider.of<UserProvider>(context, listen: false)
          .readCustomerById(order.customerid);
      await Provider.of<AddressProvider>(context, listen: false)
          .readAddressById(order.addressid);
    } else if (role == 'customer') {
      if (order.riderid != '') {
        await Provider.of<UserProvider>(context, listen: false)
            .readRiderById(order.riderid);
      }
    }
  }

  Widget buildOrderItem(OrderModel order, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      color: checkOrderStatusColor(order.track),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Provider.of<OrderProvider>(context, listen: false)
              .selectOrderWhereId(order.id);
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
                    orderStatusStream(index),
                    // Text(MyVariable.orderStatusList[order.status],
                    //     style: MyStyle().boldPrimary18()),
                    Text(MyFunction().convertToDateTime(order.time),
                        style: MyStyle().normalBlack14()),
                  ],
                ),
                ScreenWidget().buildSpacer(),
                if (role == 'manager') ...[
                  fragmentManagerDetail(order)
                ] else if (role == 'rider') ...[
                  fragmentRiderDetail(order)
                ] else if (role == 'customer') ...[
                  fragmentCustomerDetail(order)
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder orderStatusStream(int index) {
    return StreamBuilder(
      stream: OrderCRUD().readStatusOrderListStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('ไม่พบข้อมูล', style: MyStyle().boldPrimary18());
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data!;
          orderList.sort((a, b) => a.time.compareTo(b.time));
          return Text(orderList[index].status.toString(),
              style: MyStyle().boldPrimary18());
        } else {
          return const ShowProgress();
        }
      },
    );
  }

  Widget fragmentManagerDetail(OrderModel order) {
    return Consumer<UserProvider>(
      builder: (_, uprovider, __) => uprovider.customer == null ||
              uprovider.rider == null
          ? const ShowProgress()
          : Column(
              children: [
                fragmentEachRowDetail(Icons.person_rounded, 'ชื่อลูกค้า',
                    '${uprovider.customer.userFirstName} ${uprovider.customer.userLastName}'),
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
                        : '${uprovider.rider.userFirstName} ${uprovider.rider.userLastName}',
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
                        'ร้านอาหาร', sprovider.shop.shopName),
                    fragmentEachRowDetail(Icons.person_rounded, 'ชื่อลูกค้า',
                        '${uprovider.customer.userFirstName} ${uprovider.customer.userLastName}'),
                    fragmentEachRowDetail(Icons.location_pin, 'สถานที่จัดส่ง',
                        aprovider.address.addressName),
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

  Color checkOrderStatusColor(int status) {
    if (status == 0) {
      return Colors.yellow.shade100;
    } else if (status == 1) {
      return Colors.green.shade100;
    } else if (status == 2) {
      return Colors.grey.shade100;
    } else if (status == 3) {
      return Colors.red.shade100;
    } else {
      return Colors.white;
    }
  }
}
