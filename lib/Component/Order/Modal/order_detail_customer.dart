import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderDetailCustomer {
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
                            ScreenWidget().buildTitle('หมายเหตุ'),
                            SizedBox(height: 1.h),
                            buildSuggest(oprovider.order.orderCommentShop,
                                oprovider.order.orderCommentRider),
                            SizedBox(height: 2.h),
                            ScreenWidget().buildSpacer(),
                            SizedBox(height: 2.h),
                            if (oprovider.order.orderReceiveType ==
                                GlobalVariable.orderReceiveTypeList[0]) ...[
                              ScreenWidget().buildTitle('ข้อมูลเจ้าของร้าน'),
                              SizedBox(height: 1.h),
                              buildManagerInformation(context, 2),
                              SizedBox(height: 2.h),
                              ScreenWidget().buildSpacer(),
                              SizedBox(height: 2.h),
                              ScreenWidget().buildTitle('ที่อยู่ที่มารับอาหาร'),
                              SizedBox(height: 1.h),
                              buildShopAddress(context, oprovider.order.shopId),
                            ] else ...[
                              ScreenWidget().buildTitle('ข้อมูลคนขับ'),
                              SizedBox(height: 1.h),
                              buildRiderInformation(
                                  context, oprovider.order.riderId),
                              SizedBox(height: 2.h),
                              ScreenWidget().buildSpacer(),
                              SizedBox(height: 2.h),
                              ScreenWidget().buildTitle('ที่อยู่ที่มารับอาหาร'),
                              SizedBox(height: 1.h),
                              buildUserAddress(
                                  context, oprovider.order.addressId),
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
      height: 18.h,
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
            Text(type == GlobalVariable.orderReceiveTypeList[0] ? '0 ฿' : '10 ฿',
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

  Widget buildUserAddress(BuildContext context, int id) {
    return Consumer<AddressProvider>(
      builder: (_, aprovider, __) {
        Provider.of<AddressProvider>(context, listen: false)
            .getAddressWhereId(id);
        return Column(
          children: [
            Text(aprovider.address.addressName, style: MyStyle().boldBlue18()),
            Text(
              aprovider.address.addressName == 'คอนโดถนอมมิตร'
                  ? 'ตึกหมายเลข ${aprovider.address.addressDetail}'
                  : aprovider.address.addressDetail,
              style: MyStyle().normalBlack16(),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  Widget buildShopAddress(BuildContext context, int id) {
    return Consumer<ShopProvider>(
      builder: (_, sprovider, __) {
        Provider.of<ShopProvider>(context, listen: false).selectShopWhereId(id);
        return Column(
          children: [
            Text(sprovider.shop.shopName, style: MyStyle().boldBlue18()),
            Text(
              sprovider.shop.shopAddress,
              style: MyStyle().normalBlack16(),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
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

  Widget buildManagerInformation(BuildContext context, int id) {
    return Consumer<UserProvider>(builder: (_, uprovider, __) {
      Provider.of<UserProvider>(context, listen: false).getManagerWhereId(id);
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ชื่อเจ้าของร้าน : ', style: MyStyle().boldBlack16()),
              Text(
                  '${uprovider.manager.userFirstName} ${uprovider.manager.userLastName}',
                  style: MyStyle().boldPrimary16()),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('เบอร์โทร : ', style: MyStyle().boldBlack16()),
              Text(uprovider.manager.userPhone,
                  style: MyStyle().boldPrimary16()),
            ],
          ),
        ],
      );
    });
  }
}
