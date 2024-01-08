import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Model/Api/Modify/order_modify.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Model/Utility/my_variable.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Modal/select_address.dart';
import 'package:charoz/Service/Firebase/order_crud.dart';
import 'package:charoz/Service/Firebase/user_crud.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  final addVM = Get.find<AddressViewModel>();
  final orderVM = Get.find<OrderViewModel>();
  final prodVM = Get.find<ProductViewModel>();
  final shopVM = Get.find<ShopViewModel>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await addVM.readAddressList();
    addVM.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(title: 'ยืนยันออเดอร์'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (orderVM.type == 0) ...[
                  MyWidget().buildTitle(title: 'ที่อยู่ของร้านค้า'),
                  SizedBox(height: 1.h),
                  buildShopAddress(),
                ] else if (orderVM.type == 1) ...[
                  MyWidget().buildTitle(title: 'ที่อยู่สำหรับจัดส่ง'),
                  SizedBox(height: 1.h),
                  buildUserAddress(context),
                ],
                MyWidget().buildSpacer(),
                MyWidget().buildTitle(title: 'รายการอาหาร'),
                SizedBox(height: 1.h),
                buildOrderList(),
                MyWidget().buildSpacer(),
                buildTotal(),
                MyWidget().buildSpacer(),
                MyWidget().buildTitle(title: 'หมายเหตุ'),
                SizedBox(height: 1.h),
                buildSuggest(),
                SizedBox(height: 3.h),
                buildButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildShopAddress() {
    return GestureDetector(
      onTap: () => Get.toNamed(RoutePage.routeShopMap),
      child: Card(
        elevation: 5,
        child: Container(
          width: 100.w,
          padding: EdgeInsets.all(15.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.store_mall_directory_rounded,
                  size: 25.sp, color: Colors.blue),
              SizedBox(
                width: 50.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shopVM.shop.name,
                        style: MyStyle.textStyle(
                            size: 16, color: MyStyle.bluePrimary, bold: true)),
                    Text(shopVM.shop.address,
                        style: MyStyle.textStyle(
                            size: 14, color: MyStyle.blackPrimary)),
                  ],
                ),
              ),
              Icon(Icons.location_pin, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserAddress(BuildContext context) {
    return InkWell(
      onTap: () => SelectAddress().openModalSelectAddress(context),
      child: Card(
        elevation: 5,
        child: Container(
          width: 100.w,
          padding: EdgeInsets.all(15.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.home_rounded, size: 25.sp, color: Colors.blue),
              SizedBox(
                width: 50.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(addVM.address!.name, style: MyStyle().boldBlue16()),
                    // Text(
                    //     addVM.address.name == 'คอนโดถนอมมิตร'
                    //         ? 'ตึกหมายเลข ${addVM.address.detail}'
                    //         : addVM.address.detail,
                    //     style: MyStyle().normalBlack14()),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0),
      itemCount: orderVM.basketList.length,
      itemBuilder: (context, index) => buildOrderItem(
          orderVM.basketList[index], orderVM.amountList[index], index),
    );
  }

  Widget buildOrderItem(ProductModel product, int amount, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50.w,
          child: Text('${index + 1}. ${product.name} x$amount',
              style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
        ),
        Text('${(product.price! * amount).toStringAsFixed(0)} ฿',
            style: MyStyle.textStyle(
                size: 18, color: MyStyle.orangePrimary, bold: true)),
      ],
    );
  }

  Widget buildTotal() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.delivery_dining_rounded, size: 20.sp),
                SizedBox(width: 2.w),
                Text('ค่าขนส่ง : ',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.blackPrimary)),
              ],
            ),
            Text(orderVM.type == 0 ? '0 ฿' : '${shopVM.shop.freight} ฿',
                style: MyStyle.textStyle(
                    size: 18, color: MyStyle.orangePrimary, bold: true)),
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
                Text('ค่าใช้จ่ายทั้งหมด : ',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.blackPrimary)),
              ],
            ),
            Text('${orderVM.totalPay} ฿',
                style: MyStyle.textStyle(
                    size: 18, color: MyStyle.orangePrimary, bold: true)),
          ],
        ),
      ],
    );
  }

  Widget buildSuggest() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ถึงร้านค้า : ',
                style: MyStyle.textStyle(
                    size: 16, color: MyStyle.blackPrimary, bold: true)),
            Text(orderVM.commentshop == 'null' ? 'ไม่มี' : orderVM.commentshop,
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ถึงคนขับ : ',
                style: MyStyle.textStyle(
                    size: 16, color: MyStyle.blackPrimary, bold: true)),
            Text(
                orderVM.commentrider == 'null' ? 'ไม่มี' : orderVM.commentrider,
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
          ],
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () => confirmDialog(context),
        child: Text('ยืนยันการสั่งอาหาร',
            style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
      ),
    );
  }

  void confirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.receipt_rounded,
              size: 25.sp,
              color: MyStyle.orangePrimary,
            ),
            SizedBox(
              width: 45.w,
              child: Text(
                'ยืนยันการสั่งอาหารหรือไม่ ?',
                style: MyStyle.textStyle(
                    size: 18, color: MyStyle.orangePrimary, bold: true),
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
                onPressed: () {
                  Get.back();
                  EasyLoading.show(status: 'loading...');
                  processOrder(context);
                },
                child: Text('ยืนยัน',
                    style: MyStyle.textStyle(
                        size: 18, color: MyStyle.greenPrimary, bold: true)),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: Text('ยกเลิก',
                    style: MyStyle.textStyle(
                        size: 18, color: MyStyle.redPrimary, bold: true)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future processOrder(BuildContext context) async {
    List<String> idList = [];
    for (var item in orderVM.basketList) {
      idList.add(item.id!);
    }

    bool status1 = await OrderCRUD().createOrder(
      model: OrderModify(
        shopid: shopVM.shop.id,
        riderid: '',
        customerid: MyVariable.userTokenID,
        addressid: orderVM.type == 0 ? '' : addVM.address!.id,
        productid: idList.toString(),
        productamount: orderVM.amountList.toString(),
        total: orderVM.totalPay,
        delivery: false,
        commentshop: orderVM.commentshop,
        commentrider: orderVM.commentrider,
        status: 0,
        track: 0,
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );

    if (status1) {
      String? token = await UserCRUD().readTokenById(id: shopVM.shop.managerid);
      EasyLoading.dismiss();
      idList.clear();
      ConsoleLog.toast(text: 'เพิ่มรายการสั่งซื้อ สำเร็จ');
      Get.back();
      Get.back();
      MyVariable.tabController!.animateTo(3);
      if (token != null) {
        // capi.pushNotification(
        //   token,
        //   'มีออเดอร์จากลูกค้า!',
        //   'ประเภท : ${VariableData.orderReceiveList[orderVM.type]}',
        // );
      }
      orderVM.clearOrderData();
    } else {
      EasyLoading.dismiss();
      DialogAlert(context).dialogApi();
    }
  }
}
