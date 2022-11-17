import 'package:charoz/Model/Data/order_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/order_crud.dart';
import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_progress.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final UserViewModel userVM = Get.find<UserViewModel>();
final AddressViewModel addVM = Get.find<AddressViewModel>();
final OrderViewModel orderVM = Get.find<OrderViewModel>();
final ShopViewModel shopVM = Get.find<ShopViewModel>();

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
    await userVM.readCustomerById(order.customerid);
    await addVM.readAddressById(order.addressid);
  }

  Widget buildOrderItem(BuildContext context, OrderModel order, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      color: Colors.green.shade100,
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
            '${userVM.customer.firstname} ${userVM.customer.lastname}'),
        fragmentEachRowDetail(
            Icons.location_pin, 'สถานที่จัดส่ง', addVM.address.name),
        fragmentEachRowDetail(Icons.money_rounded, 'ค่าอาหารลูกค้า',
            '${order.total - order.charge} ฿'),
        fragmentEachRowDetail(
            Icons.money_rounded, 'ค่าส่งอาหาร', '${order.charge} ฿'),
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
        Text(detail, style: MyStyle().normalBlack16()),
      ],
    );
  }
}
