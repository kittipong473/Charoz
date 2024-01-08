import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderCart extends StatefulWidget {
  const OrderCart({super.key});

  @override
  State<OrderCart> createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> {
  TextEditingController shopController = TextEditingController();
  TextEditingController riderController = TextEditingController();
  String? chooseType;

  final orderVM = Get.find<OrderViewModel>();
  final shopVM = Get.find<ShopViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(title: 'ตะกร้าของคุณ'),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyWidget().buildTitle(title: 'รายการอาหาร'),
                  SizedBox(height: 2.h),
                  if (orderVM.basketList.isEmpty) ...[
                    buildEmptyOrder(),
                  ] else ...[
                    buildOrderList(),
                  ],
                  SizedBox(height: 3.h),
                  MyWidget().buildTitle(title: 'หมายเหตุเกี่ยวกับออเดอร์'),
                  SizedBox(height: 2.h),
                  buildDetailShop(),
                  SizedBox(height: 2.h),
                  buildDetailRider(),
                  SizedBox(height: 3.h),
                  MyWidget().buildTitle(title: 'ประเภทการรับอาหาร'),
                  SizedBox(height: 2.h),
                  buildType(),
                  SizedBox(height: 3.h),
                  buildButton(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmptyOrder() {
    return SizedBox(
      width: 100.w,
      height: 20.h,
      child: MyWidget().showEmptyData(
          title: 'ไม่มีสินค้าในตะกร้า',
          body: 'กรุณาเพิ่มสินค้าในตะกร้าเพื่อสั่งอาหาร'),
    );
  }

  Widget buildOrderList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0),
      itemCount: orderVM.basketList.length,
      itemBuilder: (context, index) => buildOrderItem(
          context, orderVM.basketList[index], orderVM.amountList[index]),
    );
  }

  Widget buildOrderItem(
      BuildContext context, ProductModel product, int amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50.w,
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
                height: 15.w,
                child: MyWidget()
                    .showImage(path: product.image!, fit: BoxFit.cover),
              ),
              SizedBox(width: 3.w),
              SizedBox(
                width: 30.w,
                child: Text(product.name!,
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.blackPrimary, bold: true)),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 30.w,
          child: Column(
            children: [
              Text('จำนวน : $amount',
                  style:
                      MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
              Text('${(product.price! * amount).toStringAsFixed(0)} ฿',
                  style:
                      MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            orderVM.removeOrderWhereId(product, amount);
            ConsoleLog.toast(text: 'ลบ ${product.name} ออกจากตะกร้า');
          },
          child: Icon(Icons.delete_outline_rounded,
              size: 20.sp, color: Colors.red),
        ),
      ],
    );
  }

  Widget buildDetailShop() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      width: 90.w,
      child: TextFormField(
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        keyboardType: TextInputType.number,
        controller: shopController,
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'หมายเหตุถึงร้านอาหาร(ถ้ามี) :',
          prefixIcon: const Icon(
            Icons.mode_edit_outline_rounded,
            color: MyStyle.orangeDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeDark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeLight),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRider() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      width: 90.w,
      child: TextFormField(
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        keyboardType: TextInputType.number,
        controller: riderController,
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'หมายเหตุถึงคนขับ(ถ้ามี) :',
          prefixIcon: const Icon(
            Icons.mode_edit_outline_rounded,
            color: MyStyle.orangeDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeDark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeLight),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildType() {
    return Container(
      width: 50.w,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyStyle.orangeDark),
      ),
      child: DropdownButton(
        iconSize: 24.sp,
        icon: const Icon(Icons.arrow_drop_down_outlined,
            color: MyStyle.orangePrimary),
        isExpanded: true,
        value: chooseType,
        items: orderVM.orderReceiveList.map(MyWidget().dropdownItem).toList(),
        onChanged: (value) => setState(() => chooseType = value as String),
      ),
    );
  }

  Widget buildButton() {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () => processInsert(),
        child: Text('ตรวจสอบความถูกต้อง',
            style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
      ),
    );
  }

  void processInsert() {
    if (orderVM.basketList.isEmpty) {
      DialogAlert(context)
          .dialogStatus(type: 1, title: 'ยังไม่มีสินค้าในตะกร้า');
    } else if (chooseType == null) {
      DialogAlert(context)
          .dialogStatus(type: 1, title: 'กรุณาเลือกประเภทการรับสินค้า');
    } else {
      int type = chooseType == orderVM.orderReceiveList[0] ? 0 : 1;
      orderVM.addCartToOrder(
        shopController.text.isEmpty ? 'ไม่มี' : shopController.text,
        riderController.text.isEmpty ? 'ไม่มี' : riderController.text,
        type,
      );
      orderVM.calculateTotalPay(type, shopVM.shop.freight);
      Get.toNamed(RoutePage.routeConfirmOrder);
    }
  }
}
