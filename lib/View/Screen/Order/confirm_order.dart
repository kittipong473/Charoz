import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Model/Api/Modify/order_modify.dart';
import 'package:charoz/View/Modal/select_address.dart';
import 'package:charoz/Service/Firebase/order_crud.dart';
import 'package:charoz/Service/Firebase/user_crud.dart';
import 'package:charoz/Service/Initial/route_page.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/Utility/Variable/var_general.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final AddressViewModel addVM = Get.find<AddressViewModel>();
final OrderViewModel orderVM = Get.find<OrderViewModel>();
final ProductViewModel prodVM = Get.find<ProductViewModel>();
final ShopViewModel shopVM = Get.find<ShopViewModel>();

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({Key? key}) : super(key: key);

  Future getData() async {
    await addVM.readAddressList();
    addVM.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    EasyLoading.dismiss();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.h),
                      if (orderVM.type == 0) ...[
                        ScreenWidget().buildTitle('ที่อยู่ของร้านค้า'),
                        SizedBox(height: 1.h),
                        buildShopAddress(),
                      ] else if (orderVM.type == 1) ...[
                        ScreenWidget().buildTitle('ที่อยู่สำหรับจัดส่ง'),
                        SizedBox(height: 1.h),
                        buildUserAddress(context),
                      ],
                      ScreenWidget().buildSpacer(),
                      ScreenWidget().buildTitle('รายการอาหาร'),
                      SizedBox(height: 1.h),
                      buildOrderList(),
                      ScreenWidget().buildSpacer(),
                      buildTotal(),
                      ScreenWidget().buildSpacer(),
                      ScreenWidget().buildTitle('หมายเหตุ'),
                      SizedBox(height: 1.h),
                      buildSuggest(),
                      SizedBox(height: 3.h),
                      buildButton(context),
                    ],
                  ),
                ),
              ),
            ),
            ScreenWidget().appBarTitle('ยืนยันออเดอร์'),
            ScreenWidget().backPage(context),
          ],
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
                    Text(shopVM.shop.name, style: MyStyle().boldBlue16()),
                    Text(shopVM.shop.address, style: MyStyle().normalBlack14()),
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
      itemCount: orderVM.productList.length,
      itemBuilder: (context, index) => buildOrderItem(
          orderVM.productList[index], orderVM.amountList[index], index),
    );
  }

  Widget buildOrderItem(ProductModel product, int amount, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50.w,
          child: Text('${index + 1}. ${product.name} x$amount',
              style: MyStyle().normalBlack16()),
        ),
        Text('${(product.price! * amount).toStringAsFixed(0)} ฿',
            style: MyStyle().boldPrimary18()),
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
                Text('ค่าขนส่ง : ', style: MyStyle().boldBlack16()),
              ],
            ),
            Text(orderVM.type == 0 ? '0 ฿' : '${shopVM.shop.freight} ฿',
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
            Text('${orderVM.totalPay} ฿', style: MyStyle().boldPrimary18()),
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
            Text('ถึงร้านค้า : ', style: MyStyle().boldBlack16()),
            Text(orderVM.commentshop == 'null' ? 'ไม่มี' : orderVM.commentshop,
                style: MyStyle().normalPrimary16()),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ถึงคนขับ : ', style: MyStyle().boldBlack16()),
            Text(
                orderVM.commentrider == 'null' ? 'ไม่มี' : orderVM.commentrider,
                style: MyStyle().normalPrimary16()),
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
        child: Text('ยืนยันการสั่งอาหาร', style: MyStyle().normalWhite16()),
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
                onPressed: () {
                  Navigator.pop(dialogContext);
                  EasyLoading.show(status: 'loading...');
                  processOrder(context);
                },
                child: Text('ยืนยัน', style: MyStyle().boldGreen18()),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text('ยกเลิก', style: MyStyle().boldRed18()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future processOrder(BuildContext context) async {
    List<String> idList = [];
    for (var item in orderVM.productList) {
      idList.add(item.id);
    }

    bool status1 = await OrderCRUD().createOrder(
      model: OrderModify(
        shopid: shopVM.shop.id,
        riderid: '',
        customerid: VariableGeneral.userTokenId!,
        addressid: orderVM.type == 0 ? '' : addVM.address!.id,
        productid: idList.toString(),
        productamount: orderVM.amountList.toString(),
        total: orderVM.totalPay,
        delivery: orderVM.type,
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
      MyFunction().toast('เพิ่มรายการสั่งซื้อ สำเร็จ');
      Get.back();
      Get.back();
      VariableGeneral.tabController!.animateTo(3);
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
      MyDialog(context).addFailedDialog();
    }
  }
}
