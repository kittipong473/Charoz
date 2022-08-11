import 'package:charoz/Component/Order/Modal/select_address.dart';
import 'package:charoz/Model_Sub/order_sub.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
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
                        if (oprovider.type ==
                            MyVariable.orderReceiveTypeList[0]) ...[
                          ScreenWidget().buildTitle('ที่อยู่ของร้านค้า'),
                          SizedBox(height: 1.h),
                          buildShopAddress(),
                        ] else ...[
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
                        buildButton(),
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
                      Text(provider.shop.name,
                          style: MyStyle().boldBlue16()),
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
    return Consumer2<ProductProvider, OrderProvider>(
      builder: (_, pprovider, oprovider, __) {
        List<String> productIdList =
            MyFunction().convertToList(oprovider.productidList.toString());
        List<String> productAmountList =
            MyFunction().convertToList(oprovider.productamountList.toString());
        return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 0),
            itemCount: productIdList.length,
            itemBuilder: (context, index) {
              Provider.of<ProductProvider>(context, listen: false)
                  .selectProductWhereId(productIdList[index]);
              return buildOrderItem(pprovider.product,
                  int.parse(productAmountList[index]), index);
            });
      },
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
              Text(
                  oprovider.type == MyVariable.orderReceiveTypeList[0]
                      ? '0 ฿'
                      : '${sprovider.shop.freight} ฿',
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

  Widget buildButton() {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: Consumer3<OrderProvider, AddressProvider, ShopProvider>(
        builder: (context, oprovider, aprovider, sprovider, __) =>
            aprovider.address == null
                ? const ShowProgress()
                : ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
                    onPressed: () => confirmDialog(
                      context,
                      oprovider,
                      aprovider.address.id,
                      sprovider.shop.id,
                      sprovider.shop.id,
                    ),
                    child: Text('ยืนยันการสั่งอาหาร',
                        style: MyStyle().normalWhite16()),
                  ),
      ),
    );
  }

  void confirmDialog(BuildContext context, OrderProvider oprovider,
      String addressId, String shopId, String managerId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
                  processOrder(
                      context, oprovider, addressId, shopId, managerId);
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

  Future processOrder(BuildContext context, OrderProvider oprovider,
      String addressId, String shopId, String managerId) async {
    bool status1 = await OrderCRUD().createOrder(
      OrderModify(
        shopid: shopId,
        riderid: '',
        customerid: MyVariable.userTokenId,
        addressid: addressId,
        productid: oprovider.productidList.toString(),
        productamount: oprovider.productamountList.toString(),
        charge: oprovider.type == 0 ? 0 : 10,
        total: int.parse(oprovider.totalPay.toStringAsFixed(0)),
        type: oprovider.type == MyVariable.orderReceiveTypeList[0] ? 0 : 1,
        commentshop: oprovider.commentshop,
        commentrider: oprovider.commentrider,
        status: 0,
        track: 0,
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );

    if (status1) {
      EasyLoading.dismiss();
      MyFunction().toast('เพิ่มรายการสั่งซื้อ สำเร็จ');
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routePageNavigation, (route) => false);
          MyVariable.indexPageNavigation = 3;
      Provider.of<OrderProvider>(context, listen: false).clearOrderData();
    } else {
      EasyLoading.dismiss();
      DialogAlert().addFailedDialog(context);
    }
  }
}
