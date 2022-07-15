import 'package:charoz/Component/Order/Modal/order_detail_rider.dart';
import 'package:charoz/Model/order_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderListRider extends StatelessWidget {
  const OrderListRider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 70.h,
      child: Consumer<OrderProvider>(
        builder: (_, provider, __) => provider.orderList == null
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
                itemCount: provider.orderList.length,
                itemBuilder: (context, index) {
                  Provider.of<ShopProvider>(context, listen: false)
                      .selectShopWhereId(provider.orderList[index].shopId);
                  return buildOrderItem(
                      context, provider.orderList[index], index);
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
          OrderDetailRider().openModalOrderDetail(context);
        },
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Consumer<ShopProvider>(
            builder: (_, sprovider, __) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order.orderStatus, style: MyStyle().boldPrimary18()),
                    Text(MyFunction().convertToDateTime(order.updated),
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
                        Icon(Icons.store_mall_directory_rounded,
                            size: 20.sp, color: MyStyle.bluePrimary),
                        SizedBox(width: 2.w),
                        Text('ร้านอาหาร : ', style: MyStyle().boldBlack16()),
                      ],
                    ),
                    Text(sprovider.shop.shopName,
                        style: MyStyle().normalPrimary16()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.food_bank_rounded,
                            size: 20.sp, color: MyStyle.bluePrimary),
                        SizedBox(width: 2.w),
                        Text('ประเภท : ', style: MyStyle().boldBlack16()),
                      ],
                    ),
                    Text(order.orderReceiveType,
                        style: MyStyle().normalPrimary16()),
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
                        Text('ราคา : ', style: MyStyle().boldBlack16()),
                      ],
                    ),
                    Text('${order.orderTotal} ฿',
                        style: MyStyle().normalPrimary16()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (order.orderReceiveType ==
                        GlobalVariable.orderReceiveTypeList[0]) ...[
                      Row(
                        children: [
                          Icon(Icons.location_pin,
                              size: 20.sp, color: MyStyle.bluePrimary),
                          SizedBox(width: 2.w),
                          Text('สถานที่รับ : ', style: MyStyle().boldBlack16()),
                        ],
                      ),
                      Text('คอนโดถนอมมิตร ตึก 11 ชั้นล่าง',
                          style: MyStyle().normalPrimary16()),
                    ] else ...[
                      Row(
                        children: [
                          Icon(Icons.delivery_dining_rounded,
                              size: 20.sp, color: MyStyle.bluePrimary),
                          SizedBox(width: 2.w),
                          Text('ชื่อคนขับ : ', style: MyStyle().boldBlack16()),
                        ],
                      ),
                      order.riderId == 0
                          ? Text('ยังไม่มีคนขับรับงาน',
                              style: MyStyle().normalBlack16())
                          : Text('Rider test',
                              style: MyStyle().normalPrimary16())
                    ],
                  ],
                ),
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
