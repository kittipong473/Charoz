import 'package:charoz/View/Function/manager_process.dart';
import 'package:charoz/View/Function/rider_process.dart';
import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Util/Constant/my_image.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_image.dart';
import 'package:charoz/View/Widget/show_progress.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final ProductViewModel prodVM = Get.find<ProductViewModel>();
final OrderViewModel orderVM = Get.find<OrderViewModel>();
final UserViewModel userVM = Get.find<UserViewModel>();
final ShopViewModel shopVM = Get.find<ShopViewModel>();
final AddressViewModel addVM = Get.find<AddressViewModel>();

class OrderDetail extends StatelessWidget {
  const OrderDetail({Key? key}) : super(key: key);

  void getData() {
    prodVM.readProductAllList();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              top: 9.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ScreenWidget().buildTitle('รายการที่สั่ง'),
                      SizedBox(height: 1.h),
                      buildOrderList(),
                      ScreenWidget().buildSpacer(),
                      buildTotal(),
                      ScreenWidget().buildSpacer(),
                      ScreenWidget().buildTitle('หมายเหตุ'),
                      SizedBox(height: 1.h),
                      buildSuggest(),
                      ScreenWidget().buildSpacer(),
                      if (VariableGeneral.role == 'manager') ...[
                        fragmentManagerDetail(context)
                      ] else if (VariableGeneral.role == 'rider') ...[
                        fragmentRiderDetail(context)
                      ] else if (VariableGeneral.role == 'customer') ...[
                        fragmentCustomerDetail(context)
                      ] else if (VariableGeneral.role == 'admin') ...[
                        fragmentAdminDetail(context)
                      ],
                    ],
                  ),
                ),
              ),
            ),
            ScreenWidget().appBarTitle('รายละเอียดออเดอร์'),
            ScreenWidget().backPage(context),
          ],
        ),
      ),
    );
  }

  Widget buildOrderList() {
    List<String> productIdList =
        MyFunction().convertToList(orderVM.order.productid);
    List<String> productAmountList =
        MyFunction().convertToList(orderVM.order.productamount);
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0),
      itemCount: productIdList.length,
      itemBuilder: (context, index) {
        prodVM.selectProductWhereId(productIdList[index]);
        return buildOrderItem(
            prodVM.product, int.parse(productAmountList[index]), index);
      },
    );
  }

  Widget buildOrderItem(ProductModel product, int amount, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('${index + 1}. ${product.name} x$amount',
                style: MyStyle().normalBlack16()),
            SizedBox(width: 2.w),
            SizedBox(
              width: 12.w,
              height: 12.w,
              child: ShowImage().showImage(product.image),
            ),
          ],
        ),
        Text('${(product.price * amount).toStringAsFixed(0)} ฿',
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
                Icon(Icons.restaurant_menu_rounded, size: 20.sp),
                SizedBox(width: 2.w),
                Text('ค่าอาหาร : ', style: MyStyle().boldBlack16()),
              ],
            ),
            Text('${orderVM.order.total - orderVM.order.charge} ฿',
                style: MyStyle().boldPrimary18()),
          ],
        ),
        SizedBox(height: 1.h),
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
            Text('${orderVM.order.charge} ฿', style: MyStyle().boldPrimary18()),
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
            Text('${orderVM.order.total} ฿', style: MyStyle().boldPrimary18()),
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
            Text(orderVM.order.commentshop, style: MyStyle().normalPrimary16()),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ถึงคนขับ : ', style: MyStyle().boldBlack16()),
            Text(orderVM.order.commentrider,
                style: MyStyle().normalPrimary16()),
          ],
        ),
      ],
    );
  }

  Widget fragmentManagerDetail(BuildContext context) {
    return Column(
      children: [
        ScreenWidget().buildTitle('ข้อมูลลูกค้า'),
        SizedBox(height: 1.h),
        buildCustomerInformation(context, orderVM.order.customerid),
        ScreenWidget().buildSpacer(),
        if (orderVM.order.type == 1) ...[
          ScreenWidget().buildTitle('ข้อมูลคนขับ'),
          SizedBox(height: 1.h),
          buildRiderInformation(context, orderVM.order.riderid),
        ],
        SizedBox(height: 5.h),
        if (orderVM.order.status == 0) ...[
          managerAcceptButton(context, orderVM.order.id, orderVM.order.type),
        ] else if (orderVM.order.status == 2) ...[
          managerFinishButton(context, orderVM.order.id),
        ] else if (orderVM.order.type == 0 && orderVM.order.status == 3) ...[
          managerCompleteButton(context, orderVM.order.id),
        ],
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget fragmentRiderDetail(BuildContext context) {
    return Column(
      children: [
        ScreenWidget().buildTitle('ข้อมูลลูกค้า'),
        SizedBox(height: 1.h),
        buildCustomerInformation(context, orderVM.order.customerid),
        ScreenWidget().buildSpacer(),
        ScreenWidget().buildTitle('ข้อมูลที่อยู่ลูกค้า'),
        SizedBox(height: 1.h),
        buildUserAddress(context, orderVM.order.addressid),
        SizedBox(height: 3.h),
        if (orderVM.order.status == 1) ...[
          riderAcceptButton(context, orderVM.order.id),
        ] else if (orderVM.order.status == 3) ...[
          riderReceiveButton(context, orderVM.order.id),
        ] else if (orderVM.order.status == 4) ...[
          riderSendButton(context, orderVM.order.id),
        ],
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget fragmentCustomerDetail(BuildContext context) {
    return Column(
      children: [
        if (orderVM.order.type == 0) ...[
          ScreenWidget().buildTitle('ที่อยู่ที่ไปรับอาหาร'),
          SizedBox(height: 3.h),
          buildShopAddress(context),
          SizedBox(height: 1.h),
        ] else ...[
          ScreenWidget().buildTitle('ข้อมูลคนขับ'),
          SizedBox(height: 1.h),
          buildRiderInformation(context, orderVM.order.riderid),
          ScreenWidget().buildSpacer(),
          ScreenWidget().buildTitle('ที่อยู่ที่มาส่งอาหาร'),
          SizedBox(height: 1.h),
          buildUserAddress(context, orderVM.order.addressid),
          SizedBox(height: 3.h),
        ],
        // if (orderVM.order.status == 5) ...[
        //   customerScoreButton(context, orderVM.order.id),
        //   SizedBox(height: 2.h),
        // ],
      ],
    );
  }

  Widget fragmentAdminDetail(BuildContext context) {
    return Column(
      children: [
        ScreenWidget().buildTitle('ข้อมูลลูกค้า'),
        SizedBox(height: 1.h),
        buildCustomerInformation(context, orderVM.order.customerid),
        ScreenWidget().buildSpacer(),
        if (orderVM.order.type == 1) ...[
          ScreenWidget().buildTitle('ข้อมูลคนขับ'),
          SizedBox(height: 1.h),
          buildRiderInformation(context, orderVM.order.riderid),
          ScreenWidget().buildSpacer(),
          ScreenWidget().buildTitle('ที่อยู่ที่ไปส่งอาหาร'),
          SizedBox(height: 1.h),
          buildUserAddress(context, orderVM.order.addressid),
          SizedBox(height: 3.h),
        ],
      ],
    );
  }

  Widget buildRiderInformation(BuildContext context, String riderid) {
    if (riderid != '') userVM.readRiderById(riderid);
    return SizedBox(
      width: 80.w,
      height: 10.h,
      child: ListTile(
        leading: riderid == ''
            ? Image.asset(MyImage.person)
            : userVM.rider.image == ''
                ? Image.asset(MyImage.person)
                : ShowImage().showCircleImage(userVM.rider.image),
        title: Row(
          children: [
            Text('ชื่อคนขับ  :  ', style: MyStyle().boldPrimary16()),
            riderid == ''
                ? Text('ยังไม่มีคนขับรับงาน', style: MyStyle().normalBlack16())
                : Text('${userVM.rider.firstname} ${userVM.rider.lastname}',
                    style: MyStyle().normalBlack16())
          ],
        ),
        subtitle: Row(
          children: [
            Text('เบอร์โทร  :  ', style: MyStyle().boldPrimary16()),
            riderid == ''
                ? Text('ยังไม่มีคนขับรับงาน', style: MyStyle().normalBlack16())
                : Text(userVM.rider.phone, style: MyStyle().normalBlack16()),
          ],
        ),
      ),
    );
  }

  Widget buildCustomerInformation(BuildContext context, String customerid) {
    userVM.readCustomerById(customerid);
    return SizedBox(
      width: 80.w,
      height: 10.h,
      child: ListTile(
        leading: userVM.customer.image == ''
            ? Image.asset(MyImage.person)
            : ShowImage().showCircleImage(userVM.customer.image),
        title: Row(
          children: [
            Text('ชื่อลูกค้า  :  ', style: MyStyle().boldPrimary16()),
            Text('${userVM.customer.firstname} ${userVM.customer.lastname}',
                style: MyStyle().normalBlack16()),
          ],
        ),
        subtitle: Row(
          children: [
            Text('เบอร์โทร  :  ', style: MyStyle().boldPrimary16()),
            Text(userVM.customer.phone, style: MyStyle().normalBlack16()),
          ],
        ),
      ),
    );
  }

  Widget buildShopAddress(BuildContext context) {
    shopVM.readShopModel();
    return Column(
      children: [
        SizedBox(
          width: 80.w,
          height: 30.h,
          child: ShowImage().showImage(shopVM.shop.image),
        ),
        SizedBox(height: 3.h),
        Text(shopVM.shop.name, style: MyStyle().boldBlue18()),
        SizedBox(height: 1.h),
        SizedBox(
          width: 60.w,
          child: Text(
            shopVM.shop.address,
            style: MyStyle().normalBlack16(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 1.h),
        Text('เบอร์ติดต่อ : ${shopVM.shop.phone}',
            style: MyStyle().normalBlack16()),
      ],
    );
  }

  Widget buildUserAddress(BuildContext context, String addressid) {
    addVM.readAddressById(addressid);
    return Column(
      children: [
        Text(addVM.address.type.toString(), style: MyStyle().boldBlue18()),
        Text(
          addVM.address.type.toString() == 'คอนโดถนอมมิตร'
              ? 'ตึกหมายเลข ${addVM.address.detail}'
              : addVM.address.detail,
          style: MyStyle().normalBlack16(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget managerAcceptButton(BuildContext context, String orderId, int type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () =>
                ManagerProcess(context, orderId).acceptConfirmYes(type),
            child: Text('ยืนยันออเดอร์', style: MyStyle().normalWhite16()),
          ),
        ),
        SizedBox(height: 3.h),
        SizedBox(
          width: 80.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () =>
                ManagerProcess(context, orderId).acceptConfirmNo(type),
            child: Text('ยกเลิกออเดอร์', style: MyStyle().normalWhite16()),
          ),
        ),
      ],
    );
  }

  Widget managerFinishButton(BuildContext context, String orderId) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () => ManagerProcess(context, orderId).processFinishOrder(),
        child: Text('ทำอาหารเสร็จสิ้น', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Widget managerCompleteButton(BuildContext context, String orderId) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () =>
            ManagerProcess(context, orderId).processCompleteOrder(),
        child:
            Text('ลูกค้ารับอาหารเรียบร้อย', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Widget riderAcceptButton(BuildContext context, String orderId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () => RiderProcess(context, orderId).acceptConfirmYes(),
            child: Text('ยืนยันออเดอร์', style: MyStyle().normalWhite16()),
          ),
        ),
      ],
    );
  }

  Widget riderReceiveButton(BuildContext context, String orderId) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () => RiderProcess(context, orderId).processReceiveOrder(),
        child:
            Text('รับออเดอร์และเตรียมจัดส่ง', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Widget riderSendButton(BuildContext context, String orderId) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () => RiderProcess(context, orderId).processSendOrder(),
        child: Text('จัดส่งและชำระเงินเสร็จสิ้น',
            style: MyStyle().normalWhite16()),
      ),
    );
  }

  Widget customerScoreButton(BuildContext context, String orderId) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () {},
        child: Text('ให้คะแนนรายการนี้', style: MyStyle().normalWhite16()),
      ),
    );
  }
}
