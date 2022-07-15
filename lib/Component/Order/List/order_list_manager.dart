import 'package:charoz/Component/Order/Modal/order_detail_manager.dart';
import 'package:charoz/Model/order_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderListManager extends StatelessWidget {
  const OrderListManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 70.h,
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
                  Provider.of<UserProvider>(context, listen: false)
                      .getCustomerWhereId(
                          oprovider.orderList[index].customerId);
                  if (oprovider.orderList[index].riderId != 0) {
                    Provider.of<UserProvider>(context, listen: false)
                        .getRiderWhereId(oprovider.orderList[index].riderId);
                  }
                  return buildOrderItem(
                      context, oprovider.orderList[index], index);
                },
              ),
      ),
    );
  }

  Widget buildOrderItem(BuildContext context, OrderModel order, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      color: checkOrderStatusColor(order.orderReceiveType, order.orderStatus),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Provider.of<OrderProvider>(context, listen: false)
              .selectOrderWhereId(order.orderId);
          OrderDetailManager().openModalOrderDetail(context);
        },
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Consumer<UserProvider>(
            builder: (_, uprovider, __) => uprovider.customer == null
                ? const ShowProgress()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(order.orderStatus,
                              style: MyStyle().boldPrimary18()),
                          Text(MyFunction().convertToDateTime(order.created),
                              style: MyStyle().normalBlack14()),
                        ],
                      ),
                      ScreenWidget().buildSpacer(),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.food_bank_rounded,
                                  size: 20.sp, color: MyStyle.bluePrimary),
                              SizedBox(width: 2.w),
                              Text('ประเภท : ', style: MyStyle().boldBlue16()),
                            ],
                          ),
                          Text(order.orderReceiveType,
                              style: MyStyle().normalBlack16()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person_rounded,
                                  size: 20.sp, color: MyStyle.bluePrimary),
                              SizedBox(width: 2.w),
                              Text('ชื่อลูกค้า : ',
                                  style: MyStyle().boldBlue16()),
                            ],
                          ),
                          Text(
                              '${uprovider.customer.userFirstName} ${uprovider.customer.userLastName}',
                              style: MyStyle().normalBlack16()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.money_rounded,
                                  size: 20.sp, color: MyStyle.bluePrimary),
                              SizedBox(width: 2.w),
                              Text('ราคา : ', style: MyStyle().boldBlue16()),
                            ],
                          ),
                          Text('${order.orderTotal} ฿',
                              style: MyStyle().normalBlack16()),
                        ],
                      ),
                      if (order.orderReceiveType ==
                          GlobalVariable.orderReceiveTypeList[1]) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_pin,
                                    size: 20.sp, color: MyStyle.bluePrimary),
                                SizedBox(width: 2.w),
                                Text('ชื่อคนขับ : ',
                                    style: MyStyle().boldBlue16()),
                              ],
                            ),
                            order.riderId == 0
                                ? Text('ยังไม่มีคนขับรับงาน',
                                    style: MyStyle().normalGrey16())
                                : Text(
                                    '${uprovider.rider.userFirstName} ${uprovider.rider.userLastName}',
                                    style: MyStyle().normalBlack16()),
                          ],
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Color checkOrderStatusColor(String type, String status) {
    if (type == GlobalVariable.orderReceiveTypeList[0]) {
      if (status == GlobalVariable.orderStatusReceiveList[0]) {
        return Colors.yellow.shade100;
      } else if (status == GlobalVariable.orderStatusReceiveList[1]) {
        return Colors.purple.shade100;
      } else if (status == GlobalVariable.orderStatusReceiveList[2]) {
        return Colors.green.shade100;
      } else if (status == GlobalVariable.orderStatusReceiveList[4]) {
        return Colors.red.shade100;
      } else {
        return Colors.white;
      }
    } else if (type == GlobalVariable.orderReceiveTypeList[1]) {
      if (status == GlobalVariable.orderStatusDeliveryList[0] ||
          status == GlobalVariable.orderStatusDeliveryList[1]) {
        return Colors.yellow.shade100;
      } else if (status == GlobalVariable.orderStatusDeliveryList[2]) {
        return Colors.purple.shade100;
      } else if (status == GlobalVariable.orderStatusDeliveryList[3]) {
        return Colors.green.shade100;
      } else if (status == GlobalVariable.orderStatusDeliveryList[5] ||
          status == GlobalVariable.orderStatusDeliveryList[6]) {
        return Colors.red.shade100;
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }
}
