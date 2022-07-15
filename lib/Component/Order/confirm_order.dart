import 'package:charoz/Component/Order/Modal/select_address.dart';
import 'package:charoz/Component/Shop/shop_detail.dart';
import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Api/PHP/order_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({Key? key}) : super(key: key);

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  void initState() {
    Provider.of<AddressProvider>(context, listen: false).getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer3<OrderProvider, AddressProvider, ShopProvider>(
          builder: (_, oprovider, aprovider, sprovider, __) => aprovider
                      .address ==
                  null
              ? const ShowProgress()
              : Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 8.h),
                              if (oprovider.receiveType ==
                                  GlobalVariable.orderReceiveTypeList[0]) ...[
                                ScreenWidget().buildTitle('ที่อยู่ของร้านค้า'),
                                SizedBox(height: 1.h),
                                buildShopAddress(sprovider.shop),
                              ] else ...[
                                ScreenWidget()
                                    .buildTitle('ที่อยู่สำหรับจัดส่ง'),
                                SizedBox(height: 1.h),
                                buildUserAddress(aprovider.address),
                              ],
                              SizedBox(height: 2.h),
                              ScreenWidget().buildSpacer(),
                              SizedBox(height: 2.h),
                              ScreenWidget().buildTitle('รายการอาหาร'),
                              SizedBox(height: 1.h),
                              buildOrderList(oprovider),
                              SizedBox(height: 2.h),
                              ScreenWidget().buildSpacer(),
                              SizedBox(height: 2.h),
                              buildTotal(
                                  oprovider.receiveType, oprovider.orderTotal),
                              SizedBox(height: 2.h),
                              ScreenWidget().buildSpacer(),
                              SizedBox(height: 2.h),
                              ScreenWidget().buildTitle('หมายเหตุ'),
                              SizedBox(height: 1.h),
                              buildSuggest(
                                  oprovider.detailShop, oprovider.detailRider),
                              SizedBox(height: 3.h),
                              buildButton(
                                oprovider,
                                aprovider.address.addressId,
                                sprovider.shop.shopId,
                              ),
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

  Widget buildShopAddress(ShopModel shop) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShopDetail(id: shop.shopId),
        ),
      ),
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
                    Text(shop.shopName, style: MyStyle().boldBlue16()),
                    Text(shop.shopAddress, style: MyStyle().normalBlack14()),
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

  Widget buildUserAddress(AddressModel address) {
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
                    Text(address.addressName, style: MyStyle().boldBlue16()),
                    Text(
                        address.addressName == 'คอนโดถนอมมิตร'
                            ? 'ตึกหมายเลข ${address.addressDetail}'
                            : address.addressDetail,
                        style: MyStyle().normalBlack14()),
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

  Widget buildOrderList(OrderProvider oprovider) {
    List<String> productIdList =
        MyFunction().convertToList(oprovider.orderProductIds.toString());
    List<String> productAmountList =
        MyFunction().convertToList(oprovider.orderProductAmounts.toString());
    return SizedBox(
      width: 100.w,
      height: 24.h,
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
                type == GlobalVariable.orderReceiveTypeList[1] ? '0 ฿' : '10 ฿',
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

  Widget buildSuggest(String shopDetail, String riderDetail) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ถึงร้านค้า : ', style: MyStyle().boldBlack16()),
            Text(shopDetail == 'null' ? 'ไม่มี' : shopDetail,
                style: MyStyle().normalPrimary16()),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ถึงคนขับ : ', style: MyStyle().boldBlack16()),
            Text(riderDetail == 'null' ? 'ไม่มี' : riderDetail,
                style: MyStyle().normalPrimary16()),
          ],
        ),
      ],
    );
  }

  Widget buildButton(OrderProvider oprovider, int addressId, int shopId) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () => confirmDialog(oprovider, addressId, shopId),
        child: Text('ยืนยันการสั่งอาหาร', style: MyStyle().normalWhite16()),
      ),
    );
  }

  void confirmDialog(OrderProvider oprovider, int addressId, int shopId) {
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
                  EasyLoading.show(status: 'loading...');
                  processOrder(oprovider, addressId, shopId);
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

  Future processOrder(
      OrderProvider oprovider, int addressId, int shopId) async {
    bool status = await OrderApi().insertOrder(
      shopid: shopId,
      customerid: GlobalVariable.userTokenId,
      addressid: oprovider.receiveType == GlobalVariable.orderReceiveTypeList[0]
          ? 0
          : addressId,
      productids: oprovider.orderProductIds.toString(),
      amounts: oprovider.orderProductAmounts.toString(),
      total: oprovider.orderTotal,
      receive: oprovider.receiveType,
      commentS: oprovider.detailShop,
      commentR: oprovider.detailRider,
      time: DateTime.now(),
    );

    if (status) {
      EasyLoading.dismiss();
      MyFunction().toast('เพิ่มรายการสั่งซื้อ สำเร็จ');
      GlobalVariable.indexPageNavigation = 3;
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routePageNavigation, (route) => false);
      Provider.of<OrderProvider>(context, listen: false).clearOrder();
    } else {
      EasyLoading.dismiss();
      DialogAlert().addFailedDialog(context);
    }
  }
}
