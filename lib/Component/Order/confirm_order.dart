import 'package:charoz/Component/Order/Modal/select_address.dart';
import 'package:charoz/Model_Main/shop_model.dart';
import 'package:charoz/Model_Sub/order_modify.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Database/Firebase/order_crud.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({Key? key}) : super(key: key);

  Future getData(BuildContext context) async {
    await Provider.of<AddressProvider>(context, listen: false)
        .readAddressList();
    Provider.of<AddressProvider>(context, listen: false).getAddress();
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    EasyLoading.dismiss();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<OrderProvider>(
          builder: (_, oprovider, __) => Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8.h),
                        if (oprovider.type == 0) ...[
                          ScreenWidget().buildTitle('ที่อยู่ของร้านค้า'),
                          SizedBox(height: 1.h),
                          buildShopAddress(),
                        ] else if (oprovider.type == 1) ...[
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
      ),
    );
  }

  Widget buildShopAddress() {
    return Consumer<ShopProvider>(
      builder: (context, provider, __) => InkWell(
        onTap: () => Navigator.pushNamed(context, RoutePage.routeShopMap),
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
                      Text(provider.shop.name, style: MyStyle().boldBlue16()),
                      Text(provider.shop.address,
                          style: MyStyle().normalBlack14()),
                    ],
                  ),
                ),
                Icon(Icons.location_pin, size: 20.sp),
              ],
            ),
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
                child: Consumer<AddressProvider>(
                  builder: (_, provider, __) => provider.address == null
                      ? const ShowProgress()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(provider.address.name,
                                style: MyStyle().boldBlue16()),
                            Text(
                                provider.address.name == 'คอนโดถนอมมิตร'
                                    ? 'ตึกหมายเลข ${provider.address.detail}'
                                    : provider.address.detail,
                                style: MyStyle().normalBlack14()),
                          ],
                        ),
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
    return Consumer<OrderProvider>(
      builder: (_, provider, __) => ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0),
        itemCount: provider.productList.length,
        itemBuilder: (context, index) => buildOrderItem(
            provider.productList[index], provider.amountList[index], index),
      ),
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
        Text('${(product.price * amount).toStringAsFixed(0)} ฿',
            style: MyStyle().boldPrimary18()),
      ],
    );
  }

  Widget buildTotal() {
    return Consumer2<OrderProvider, ShopProvider>(
      builder: (_, oprovider, sprovider, __) => Column(
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
              Text(oprovider.type == 0 ? '0 ฿' : '${sprovider.shop.freight} ฿',
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
              Text('${oprovider.totalPay} ฿', style: MyStyle().boldPrimary18()),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSuggest() {
    return Consumer<OrderProvider>(
      builder: (_, provider, __) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ถึงร้านค้า : ', style: MyStyle().boldBlack16()),
              Text(
                  provider.commentshop == 'null'
                      ? 'ไม่มี'
                      : provider.commentshop,
                  style: MyStyle().normalPrimary16()),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ถึงคนขับ : ', style: MyStyle().boldBlack16()),
              Text(
                  provider.commentrider == 'null'
                      ? 'ไม่มี'
                      : provider.commentrider,
                  style: MyStyle().normalPrimary16()),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () => confirmDialog(context),
        child: Text('ยืนยันการสั่งอาหาร', style: MyStyle().normalWhite16()),
      ),
    );
  }

  void confirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) =>
          Consumer3<OrderProvider, AddressProvider, ShopProvider>(
        builder: (_, oprovider, aprovider, sprovider, __) => AlertDialog(
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
                    processOrder(context, oprovider, sprovider.shop,
                        aprovider.address.id);
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
      ),
    );
  }

  Future processOrder(BuildContext context, OrderProvider oprovider,
      ShopModel shop, String addressId) async {
    List<String> idList = [];
    for (var item in oprovider.productList) {
      idList.add(item.id);
    }

    bool status1 = await OrderCRUD().createOrder(
      OrderModify(
        shopid: shop.id,
        riderid: '',
        customerid: MyVariable.userTokenId,
        addressid: oprovider.type == 0 ? '' : addressId,
        productid: idList.toString(),
        productamount: oprovider.amountList.toString(),
        charge: oprovider.type == 0 ? 0 : shop.freight,
        total: oprovider.totalPay,
        type: oprovider.type,
        commentshop: oprovider.commentshop,
        commentrider: oprovider.commentrider,
        status: 0,
        track: 0,
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );

    if (status1) {
      EasyLoading.dismiss();
      idList.clear();
      MyFunction().toast('เพิ่มรายการสั่งซื้อ สำเร็จ');
      Navigator.pop(context);
      Navigator.pop(context);
      MyVariable.tabController!.animateTo(3);
      Provider.of<OrderProvider>(context, listen: false).clearOrderData();
    } else {
      EasyLoading.dismiss();
      DialogAlert().addFailedDialog(context);
    }
  }
}
