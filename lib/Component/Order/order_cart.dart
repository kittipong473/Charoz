import 'package:charoz/Component/Order/Modal/select_address.dart';
import 'package:charoz/Model_Main/address_model.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/dropdown_menu.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

TextEditingController shopController = TextEditingController();
TextEditingController riderController = TextEditingController();
String? chooseType;
double total = 0;

class OrderCart extends StatelessWidget {
  const OrderCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('ตะกร้าของคุณ'),
        body: Consumer<OrderProvider>(
          builder: (_, oprovider, __) => GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                Positioned.fill(
                  top: 2.h,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ScreenWidget().buildTitle('รายการอาหาร'),
                          SizedBox(height: 2.h),
                          if (oprovider.productidList.isEmpty) ...[
                            buildEmptyOrder(),
                          ] else ...[
                            buildOrderList(oprovider),
                          ],
                          SizedBox(height: 3.h),
                          ScreenWidget().buildTitle('หมายเหตุเกี่ยวกับออเดอร์'),
                          SizedBox(height: 2.h),
                          buildDetailShop(),
                          SizedBox(height: 2.h),
                          buildDetailRider(),
                          SizedBox(height: 3.h),
                          ScreenWidget().buildTitle('ประเภทการรับอาหาร'),
                          SizedBox(height: 2.h),
                          buildType(),
                          SizedBox(height: 3.h),
                          buildButton(context, oprovider.productidList),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
      child: ScreenWidget().showEmptyData(
          'ไม่มีสินค้าในตะกร้า', 'กรุณาเพิ่มสินค้าในตะกร้าเพื่อสั่งอาหาร'),
    );
  }

  Widget buildOrderList(OrderProvider oprovider) {
    total = 0;
    List<String> productIdList =
        MyFunction().convertToList(oprovider.productidList.toString());
    List<String> productAmountList =
        MyFunction().convertToList(oprovider.productamountList.toString());
    return Consumer<ProductProvider>(
      builder: (_, pprovider, __) => ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 0),
          itemCount: productIdList.length,
          itemBuilder: (context, index) {
            Provider.of<ProductProvider>(context, listen: false)
                .selectProductWhereId(productIdList[index]);
            total += pprovider.product.price *
                int.parse(productAmountList[index]);
            return buildOrderItem(context, pprovider.product,
                int.parse(productAmountList[index]), index);
          }),
    );
  }

  Widget buildOrderItem(
      BuildContext context, ProductModel product, int amount, int index) {
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
                child: ShowImage().showImage(product.image),
              ),
              SizedBox(width: 3.w),
              SizedBox(
                width: 30.w,
                child: Text(product.name, style: MyStyle().boldPrimary16()),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 30.w,
          child: Column(
            children: [
              Text('จำนวน : $amount', style: MyStyle().normalBlack16()),
              Text('${(product.price * amount).toStringAsFixed(0)} ฿',
                  style: MyStyle().normalBlack16()),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Provider.of<OrderProvider>(context, listen: false)
                .removeOrderWhereId(product.id, amount);
            total -= product.price * amount;
            MyFunction().toast('ลบ ${product.name} ออกจากตะกร้า');
          },
          child: Icon(Icons.delete_outline_rounded,
              size: 20.sp, color: Colors.red),
        ),
      ],
    );
  }

  Widget buildAddress(BuildContext context, AddressModel address) {
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
                    Text(address.name, style: MyStyle().boldBlue16()),
                    Text(
                        address.name == 'คอนโดถนอมมิตร'
                            ? 'ตึกหมายเลข ${address.detail}'
                            : address.detail,
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

  Widget buildDetailShop() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      width: 90.w,
      child: TextFormField(
        style: MyStyle().normalBlack16(),
        keyboardType: TextInputType.number,
        controller: shopController,
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'หมายเหตุถึงร้านอาหาร(ถ้ามี) :',
          errorStyle: MyStyle().normalRed14(),
          prefixIcon: const Icon(
            Icons.mode_edit_outline_rounded,
            color: MyStyle.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.light),
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
        style: MyStyle().normalBlack16(),
        keyboardType: TextInputType.number,
        controller: riderController,
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'หมายเหตุถึงคนขับ(ถ้ามี) :',
          errorStyle: MyStyle().normalRed14(),
          prefixIcon: const Icon(
            Icons.mode_edit_outline_rounded,
            color: MyStyle.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.light),
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
        border: Border.all(color: MyStyle.dark),
      ),
      child: StatefulBuilder(
        builder: (context, setState) => DropdownButton(
          iconSize: 24.sp,
          icon: const Icon(Icons.arrow_drop_down_outlined,
              color: MyStyle.primary),
          isExpanded: true,
          value: chooseType,
          items: MyVariable.orderReceiveTypeList.map(DropDownMenu().dropdownItem).toList(),
          onChanged: (value) =>
              setState(() => chooseType = value as String),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, List orderProducts) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () {
          if (orderProducts.isEmpty) {
            DialogAlert().singleDialog(context, 'ยังไม่มีสินค้าในตะกร้า');
          } else if (chooseType == null) {
            DialogAlert().singleDialog(context, 'กรุณาเลือกประเภทการรับสินค้า');
          } else {
            Provider.of<OrderProvider>(context, listen: false).addDetailOrder(
              shopController.text.isEmpty ? 'null' : shopController.text,
              riderController.text.isEmpty ? 'null' : riderController.text,
              chooseType!,
              total,
            );
            Navigator.pushNamed(context, RoutePage.routeConfirmOrder);
          }
        },
        child: Text('ตรวจสอบความถูกต้อง', style: MyStyle().normalWhite16()),
      ),
    );
  }
}
