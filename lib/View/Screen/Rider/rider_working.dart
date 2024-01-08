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

class RiderWorking extends StatefulWidget {
  const RiderWorking({super.key});

  @override
  State<RiderWorking> createState() => _RiderWorkingState();
}

class _RiderWorkingState extends State<RiderWorking> {
  final UserViewModel userVM = Get.find<UserViewModel>();
  final AddressViewModel addVM = Get.find<AddressViewModel>();
  final OrderViewModel orderVM = Get.find<OrderViewModel>();
  final ShopViewModel shopVM = Get.find<ShopViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: StreamBuilder(
          stream: OrderCRUD().readOrderRiderListByAccept(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return buildEmptyOrder();
            } else if (snapshot.hasData) {
              List<OrderModel> orderList = snapshot.data!;
              orderList.sort((a, b) => b.time!.compareTo(a.time!));
              return orderList.isEmpty
                  ? buildEmptyOrder()
                  : buildOrderList(orderList);
            } else {
              return MyWidget().showProgress();
            }
          },
        ),
      ),
    );
  }

  Widget buildEmptyOrder() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('ยังไม่มี รายการอาหาร ที่รับมา',
              style: MyStyle.textStyle(size: 18, color: MyStyle.orangePrimary)),
          SizedBox(height: 3.h),
          Text('รอรายการอาหาร จากลูกค้าได้ในภายหลัง',
              style: MyStyle.textStyle(size: 18, color: MyStyle.orangePrimary)),
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
        getDetailOrder(orderList[index]);
        return buildOrderItem(orderList[index], index);
      },
    );
  }

  Future getDetailOrder(OrderModel order) async {
    await userVM.readCustomerById(order.customerid!);
    await addVM.readAddressById(order.addressid!);
  }

  Widget buildOrderItem(OrderModel order, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      color: Colors.green.shade100,
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
              fragmentDetail(order),
            ],
          ),
        ),
      ),
    );
  }

  Widget fragmentDetail(OrderModel order) {
    return Column(
      children: [
        fragmentEachRowDetail(
            Icons.store_mall_directory_rounded, 'ร้านอาหาร', shopVM.shop.name),
        fragmentEachRowDetail(Icons.person_rounded, 'ชื่อลูกค้า',
            '${userVM.customer!.firstname} ${userVM.customer!.lastname}'),
        fragmentEachRowDetail(Icons.location_pin, 'สถานที่จัดส่ง',
            addVM.address!.type.toString()),
        fragmentEachRowDetail(Icons.money_rounded, 'ค่าอาหารลูกค้า',
            '${order.total! - shopVM.shop.freight} ฿'),
        fragmentEachRowDetail(
            Icons.money_rounded, 'ค่าส่งอาหาร', '${shopVM.shop.freight} ฿'),
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
        Text(detail,
            style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
      ],
    );
  }
}
