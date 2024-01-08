import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final prodVM = Get.find<ProductViewModel>();
  final orderVM = Get.find<OrderViewModel>();
  final userVM = Get.find<UserViewModel>();
  final shopVM = Get.find<ShopViewModel>();
  final addVM = Get.find<AddressViewModel>();

  @override
  void initState() {
    super.initState();
    prodVM.readProductAllList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(title: 'รายละเอียดออเดอร์'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyWidget().buildTitle(title: 'รายการที่สั่ง'),
                SizedBox(height: 1.h),
                buildOrderList(),
                MyWidget().buildSpacer(),
                buildTotal(),
                MyWidget().buildSpacer(),
                MyWidget().buildTitle(title: 'หมายเหตุ'),
                SizedBox(height: 1.h),
                buildSuggest(),
                MyWidget().buildSpacer(),
                if (userVM.role == 3) ...[
                  fragmentManagerDetail(context)
                ] else if (userVM.role == 2) ...[
                  fragmentRiderDetail(context)
                ] else if (userVM.role == 1) ...[
                  fragmentCustomerDetail(context)
                ] else if (userVM.role == 4) ...[
                  fragmentAdminDetail(context)
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrderList() {
    List<String> productIdList =
        MyFunction().convertToList(value: orderVM.order!.productid!);
    List<String> productAmountList =
        MyFunction().convertToList(value: orderVM.order!.productamount!);
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0),
      itemCount: productIdList.length,
      itemBuilder: (context, index) {
        prodVM.selectProductWhereId(productIdList[index]);
        return buildOrderItem(
            prodVM.product!, int.parse(productAmountList[index]), index);
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
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
            SizedBox(width: 2.w),
            SizedBox(
              width: 12.w,
              height: 12.w,
              child:
                  MyWidget().showImage(path: product.image!, fit: BoxFit.cover),
            ),
          ],
        ),
        Text('${(product.price! * amount).toStringAsFixed(0)} ฿',
            style: MyStyle.textStyle(size: 18, color: MyStyle.orangePrimary)),
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
                Text('ค่าอาหาร : ',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.blackPrimary)),
              ],
            ),
            Text('${orderVM.order!.total!} ฿',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
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
                Text('ค่าขนส่ง : ',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.blackPrimary)),
              ],
            ),
            Text('${orderVM.order} ฿',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
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
            Text('${orderVM.order} ฿',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
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
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
            Text(orderVM.order?.commentshop ?? '-',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ถึงคนขับ : ',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
            Text(orderVM.order?.commentrider ?? '-',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
          ],
        ),
      ],
    );
  }

  Widget fragmentManagerDetail(BuildContext context) {
    return Column(
      children: [
        MyWidget().buildTitle(title: 'ข้อมูลลูกค้า'),
        SizedBox(height: 1.h),
        buildCustomerInformation(context, orderVM.order!.customerid!),
        MyWidget().buildSpacer(),
        // if (orderVM.order!.type == 1) ...[
        //   MyWidget().buildTitle(title: 'ข้อมูลคนขับ'),
        //   SizedBox(height: 1.h),
        //   buildRiderInformation(context, orderVM.order!.riderid!),
        // ],
        // SizedBox(height: 5.h),
        // if (orderVM.order!.status == 0) ...[
        //   managerAcceptButton(context, orderVM.order!.id!, orderVM.order.type),
        // ] else if (orderVM.order!.status == 2) ...[
        //   managerFinishButton(context, orderVM.order!.id!),
        // ] else if (orderVM.order!.type == 0 && orderVM.order.status == 3) ...[
        //   managerCompleteButton(context, orderVM.order!.id!),
        // ],
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget fragmentRiderDetail(BuildContext context) {
    return Column(
      children: [
        MyWidget().buildTitle(title: 'ข้อมูลลูกค้า'),
        SizedBox(height: 1.h),
        buildCustomerInformation(context, orderVM.order!.customerid!),
        MyWidget().buildSpacer(),
        MyWidget().buildTitle(title: 'ข้อมูลที่อยู่ลูกค้า'),
        SizedBox(height: 1.h),
        buildUserAddress(context, orderVM.order!.addressid!),
        SizedBox(height: 3.h),
        // if (orderVM.order.status == 1) ...[
        //   riderAcceptButton(context, orderVM.order.id),
        // ] else if (orderVM.order.status == 3) ...[
        //   riderReceiveButton(context, orderVM.order.id),
        // ] else if (orderVM.order.status == 4) ...[
        //   riderSendButton(context, orderVM.order.id),
        // ],
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget fragmentCustomerDetail(BuildContext context) {
    return Column(
      children: [
        // if (orderVM.order.type == 0) ...[
        //   MyWidget().buildTitle(title: 'ที่อยู่ที่ไปรับอาหาร'),
        //   SizedBox(height: 3.h),
        //   buildShopAddress(context),
        //   SizedBox(height: 1.h),
        // ] else ...[
        //   MyWidget().buildTitle(title: 'ข้อมูลคนขับ'),
        //   SizedBox(height: 1.h),
        //   buildRiderInformation(context, orderVM.order.riderid),
        //   MyWidget().buildSpacer(),
        //   MyWidget().buildTitle(title: 'ที่อยู่ที่มาส่งอาหาร'),
        //   SizedBox(height: 1.h),
        //   buildUserAddress(context, orderVM.order.addressid),
        //   SizedBox(height: 3.h),
        // ],
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
        MyWidget().buildTitle(title: 'ข้อมูลลูกค้า'),
        SizedBox(height: 1.h),
        // buildCustomerInformation(context, orderVM.order.customerid),
        MyWidget().buildSpacer(),
        // if (orderVM.order.type == 1) ...[
        //   MyWidget().buildTitle(title: 'ข้อมูลคนขับ'),
        //   SizedBox(height: 1.h),
        //   buildRiderInformation(context, orderVM.order.riderid),
        //   MyWidget().buildSpacer(),
        //   MyWidget().buildTitle(title: 'ที่อยู่ที่ไปส่งอาหาร'),
        //   SizedBox(height: 1.h),
        //   buildUserAddress(context, orderVM.order.addressid),
        //   SizedBox(height: 3.h),
        // ],
      ],
    );
  }

  Widget buildRiderInformation(BuildContext context, String riderid) {
    if (riderid != '') userVM.readRiderById(riderid);
    return SizedBox(
      width: 80.w,
      height: 10.h,
      child: ListTile(
        leading: MyWidget().showImage(path: MyImage.imgPerson),
        title: Row(
          children: [
            Text('ชื่อคนขับ  :  ',
                style: MyStyle.textStyle(
                    size: 16, color: MyStyle.orangePrimary, bold: true)),
            riderid == ''
                ? Text('ยังไม่มีคนขับรับงาน',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.blackPrimary))
                : Text('${userVM.rider!.firstname} ${userVM.rider!.lastname}',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.blackPrimary))
          ],
        ),
        subtitle: Row(
          children: [
            Text('เบอร์โทร  :  ',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
            riderid == ''
                ? Text('ยังไม่มีคนขับรับงาน',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.blackPrimary))
                : Text(userVM.rider!.phone!,
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.blackPrimary)),
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
        leading: MyWidget().showImage(path: MyImage.imgPerson),
        title: Row(
          children: [
            Text('ชื่อลูกค้า  :  ',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
            Text('${userVM.customer!.firstname} ${userVM.customer!.lastname}',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
          ],
        ),
        subtitle: Row(
          children: [
            Text('เบอร์โทร  :  ',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
            Text(userVM.customer!.phone!,
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
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
          child:
              MyWidget().showImage(path: shopVM.shop.image, fit: BoxFit.cover),
        ),
        SizedBox(height: 3.h),
        Text(shopVM.shop.name,
            style: MyStyle.textStyle(size: 16, color: MyStyle.bluePrimary)),
        SizedBox(height: 1.h),
        SizedBox(
          width: 60.w,
          child: Text(
            shopVM.shop.address,
            style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 1.h),
        Text('เบอร์ติดต่อ : ${shopVM.shop.phone}',
            style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
      ],
    );
  }

  Widget buildUserAddress(BuildContext context, String addressid) {
    addVM.readAddressById(addressid);
    return Column(
      children: [
        // Text(addVM.address!.type.toString(), style: MyStyle().boldBlue18()),
        // Text(
        //   addVM.address.type.toString() == 'คอนโดถนอมมิตร'
        //       ? 'ตึกหมายเลข ${addVM.address.detail}'
        //       : addVM.address.detail,
        //   style: MyStyle().normalBlack16(),
        //   textAlign: TextAlign.center,
        // ),
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {},
            child: Text('ยืนยันออเดอร์',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
          ),
        ),
        SizedBox(height: 3.h),
        SizedBox(
          width: 80.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {},
            child: Text('ยกเลิกออเดอร์',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
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
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {},
        child: Text('ทำอาหารเสร็จสิ้น',
            style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
      ),
    );
  }

  Widget managerCompleteButton(BuildContext context, String orderId) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {},
        child: Text('ลูกค้ารับอาหารเรียบร้อย',
            style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {},
            child: Text('ยืนยันออเดอร์',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
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
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {},
        child: Text('รับออเดอร์และเตรียมจัดส่ง',
            style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
      ),
    );
  }

  Widget riderSendButton(BuildContext context, String orderId) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {},
        child: Text('จัดส่งและชำระเงินเสร็จสิ้น',
            style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
      ),
    );
  }

  Widget customerScoreButton(BuildContext context, String orderId) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {},
        child: Text('ให้คะแนนรายการนี้',
            style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
      ),
    );
  }
}
