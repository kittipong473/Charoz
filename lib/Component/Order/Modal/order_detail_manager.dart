import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Api/PHP/order_api.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderDetailManager {
  Future<dynamic> openModalOrderDetail(context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => modalOrderDetail());

  Widget modalOrderDetail() {
    return SizedBox(
      width: 100.w,
      height: 90.h,
      child: StatefulBuilder(
        builder: (context, setState) => Consumer<OrderProvider>(
          builder: (_, oprovider, __) => oprovider.order == null
              ? const ShowProgress()
              : Stack(
                  children: [
                    Positioned.fill(
                      top: 5.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          children: [
                            ScreenWidget().buildTitle('รายการที่สั่ง'),
                            SizedBox(height: 1.h),
                            buildOrderList(oprovider),
                            SizedBox(height: 2.h),
                            ScreenWidget().buildSpacer(),
                            SizedBox(height: 2.h),
                            buildTotal(oprovider.order.orderReceiveType,
                                oprovider.order.orderTotal),
                            SizedBox(height: 2.h),
                            ScreenWidget().buildSpacer(),
                            SizedBox(height: 2.h),
                            ScreenWidget().buildTitle('หมายเหตุจากลูกค้า'),
                            SizedBox(height: 1.h),
                            buildSuggest(oprovider.order.orderCommentShop),
                            SizedBox(height: 2.h),
                            ScreenWidget().buildSpacer(),
                            if (oprovider.order.orderReceiveType ==
                                GlobalVariable.orderReceiveTypeList[1]) ...[
                              SizedBox(height: 2.h),
                              ScreenWidget().buildTitle('ข้อมูลคนขับ'),
                              SizedBox(height: 1.h),
                              buildRiderInformation(
                                  context, oprovider.order.riderId),
                              SizedBox(height: 2.h),
                              ScreenWidget().buildSpacer(),
                            ],
                            SizedBox(height: 5.h),
                            if (oprovider.order.orderStatus ==
                                'รอการยืนยันจากร้านค้า') ...[
                              buildAcceptButton(
                                  context, oprovider.order.orderId),
                            ] else if (oprovider.order.orderStatus ==
                                'กำลังจัดทำอาหาร') ...[
                              buildFinishButton(context),
                            ],
                          ],
                        ),
                      ),
                    ),
                    ScreenWidget().modalTitle('รายละเอียดออเดอร์'),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildOrderList(OrderProvider oprovider) {
    List<String> productIdList =
        MyFunction().convertToList(oprovider.order.productIds);
    List<String> productAmountList =
        MyFunction().convertToList(oprovider.order.orderProductAmounts);
    return SizedBox(
      width: 100.w,
      height: 25.h,
      child: Consumer<ProductProvider>(
        builder: (_, pprovider, __) => ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 0),
            itemCount: productIdList.length,
            itemBuilder: (context, index) {
              Provider.of<ProductProvider>(context, listen: false)
                  .selectProductWhereId(int.parse(productIdList[index]));
              return buildOrderItem(pprovider.product,
                  int.parse(productAmountList[index]), index);
            }),
      ),
    );
  }

  Widget buildOrderItem(ProductModel product, int amount, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50.w,
          child: Text('${index + 1}. ${product.productName} x$amount',
              style: MyStyle().normalBlack16()),
        ),
        Text('${(product.productPrice * amount).toStringAsFixed(0)} ฿',
            style: MyStyle().boldPrimary18()),
      ],
    );
  }

  Widget buildTotal(String type, double total) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.delivery_dining_rounded, size: 20.sp),
                SizedBox(width: 2.w),
                Text('ค่าขนส่ง : ', style: MyStyle().boldBlack16()),
              ],
            ),
            Text(
                type == GlobalVariable.orderReceiveTypeList[0] ? '0 ฿' : '10 ฿',
                style: MyStyle().boldPrimary18()),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.money_rounded, size: 20.sp),
                SizedBox(width: 2.w),
                Text('ค่าใช้จ่ายทั้งหมด : ', style: MyStyle().boldBlack16()),
              ],
            ),
            Text('$total ฿', style: MyStyle().boldPrimary18()),
          ],
        ),
      ],
    );
  }

  Widget buildSuggest(String shopDetail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('ถึงร้านค้า : ', style: MyStyle().boldBlack16()),
        Text(shopDetail == 'null' ? 'ไม่มี' : shopDetail,
            style: MyStyle().normalPrimary16()),
      ],
    );
  }

  Widget buildRiderInformation(BuildContext context, int id) {
    return Consumer<UserProvider>(builder: (_, uprovider, __) {
      if (id != 0) {
        Provider.of<UserProvider>(context, listen: false).getRiderWhereId(id);
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ชื่อคนขับ : ', style: MyStyle().boldBlack16()),
              id == 0
                  ? Text('ยังไม่มีคนขับรับงาน',
                      style: MyStyle().normalBlack16())
                  : Text(
                      '${uprovider.rider.userFirstName} ${uprovider.rider.userLastName}',
                      style: MyStyle().normalPrimary16())
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('เบอร์โทร : ', style: MyStyle().boldBlack16()),
              id == 0
                  ? Text('ยังไม่มีคนขับรับงาน',
                      style: MyStyle().normalBlack16())
                  : Text(uprovider.rider.userPhone,
                      style: MyStyle().boldPrimary16()),
            ],
          ),
        ],
      );
    });
  }

  Widget buildAcceptButton(BuildContext context, int id) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () => confirmDialog(context, id),
        child: Text('ยืนยันออเดอร์', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Widget buildFinishButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () {},
        child: Text('ทำอาหารสำเร็จ', style: MyStyle().normalWhite16()),
      ),
    );
  }

  void confirmDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.receipt_rounded,
              size: 25.sp,
              color: MyStyle.primary,
            ),
            SizedBox(
              width: 45.w,
              child: Text(
                'ยืนยันการรับออเดอร์หรือไม่ ?',
                style: MyStyle().boldPrimary18(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  bool status = await OrderApi()
                      .editStatusWhereOrder(id: id, status: "กำลังจัดทำอาหาร");
                  if (status) {
                    Provider.of<OrderProvider>(context, listen: false)
                        .getAllOrderWhereManager();
                    MyFunction().toast('เปลี่ยนสถานะเรียบร้อย');
                    Navigator.pop(context);
                  } else {
                    DialogAlert().doubleDialog(context, 'เปลี่ยนสถานะล้มเหลว',
                        'กรุณาลองใหม่อีกครั้งในภายหลัง');
                  }
                },
                child: Text('ยืนยัน', style: MyStyle().boldGreen18()),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก', style: MyStyle().boldRed18()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
