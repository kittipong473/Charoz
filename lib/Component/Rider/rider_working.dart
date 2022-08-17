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

class RiderWorking extends StatelessWidget {
  const RiderWorking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              top: 2.h,
              child: riderOrder(),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder riderOrder() {
    return StreamBuilder(
      stream: OrderCRUD().readOrderRiderListByAccept(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return buildEmptyOrder();
        } else if (snapshot.hasData) {
          List<OrderModel> orderList = snapshot.data;
          orderList.sort((a, b) => b.time.compareTo(a.time));
          return orderList.isEmpty
              ? buildEmptyOrder()
              : buildOrderList(orderList);
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
          Text('ยังไม่มี รายการอาหาร ที่รับมา',
              style: MyStyle().normalPrimary18()),
          SizedBox(height: 3.h),
          Text('รอรายการอาหาร จากลูกค้าได้ในภายหลัง',
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
        getDetailOrder(context, orderList[index]);
        return buildOrderItem(context, orderList[index], index);
      },
    );
  }

  Future getDetailOrder(BuildContext context, OrderModel order) async {
    await Provider.of<UserProvider>(context, listen: false)
        .readCustomerById(order.customerid);
    await Provider.of<AddressProvider>(context, listen: false)
        .readAddressById(order.addressid);
  }

  Widget buildOrderItem(BuildContext context, OrderModel order, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      color: Colors.green.shade100,
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Provider.of<OrderProvider>(context, listen: false)
              .setOrderModel(order);
          Navigator.pushNamed(context, RoutePage.routeOrderDetail);
        },
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
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
              fragmentDetail(order),
            ],
          ),
        ),
      ),
    );
  }

  Widget fragmentDetail(OrderModel order) {
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
                    fragmentEachRowDetail(Icons.money_rounded,
                        'ค่าอาหารลูกค้า', '${order.total - order.charge} ฿'),
                    fragmentEachRowDetail(
                        Icons.money_rounded, 'ค่าส่งอาหาร', '${order.charge} ฿'),
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
        Text(detail, style: MyStyle().normalBlack16()),
      ],
    );
  }
}
