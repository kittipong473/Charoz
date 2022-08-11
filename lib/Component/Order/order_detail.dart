import 'package:charoz/Component/Order/Process/manager_process.dart';
import 'package:charoz/Component/Order/Process/rider_process.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

String role = MyVariable.role;

class OrderDetail extends StatelessWidget {
  const OrderDetail({Key? key}) : super(key: key);

  void getData(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).readProductAllList();
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
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
                      if (role == 'manager') ...[
                        fragmentManagerDetail(context)
                      ] else if (role == 'rider') ...[
                        fragmentRiderDetail(context)
                      ] else if (role == 'customer') ...[
                        fragmentCustomerDetail(context)
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
    return Consumer2<ProductProvider, OrderProvider>(
      builder: (_, pprovider, oprovider, __) {
        if (oprovider.order == null) {
          return const ShowProgress();
        } else {
          List<String> productIdList =
              MyFunction().convertToList(oprovider.order.productid);
          List<String> productAmountList =
              MyFunction().convertToList(oprovider.order.productamount);
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
        }
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
    return Consumer<OrderProvider>(
      builder: (_, provider, __) => Column(
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
              Text(provider.order.type == 0 ? '0 ฿' : '10 ฿',
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
              Text('${provider.order.total} ฿',
                  style: MyStyle().boldPrimary18()),
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
                  provider.order.commentshop == ''
                      ? 'ไม่มี'
                      : provider.order.commentshop,
                  style: MyStyle().normalPrimary16()),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ถึงคนขับ : ', style: MyStyle().boldBlack16()),
              Text(
                  provider.order.commentrider == ''
                      ? 'ไม่มี'
                      : provider.order.commentrider,
                  style: MyStyle().normalPrimary16()),
            ],
          ),
        ],
      ),
    );
  }

  Widget fragmentManagerDetail(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (_, oprovider, __) => Column(
        children: [
          ScreenWidget().buildTitle('ข้อมูลลูกค้า'),
          SizedBox(height: 1.h),
          buildCustomerInformation(context, oprovider.order.customerid),
          ScreenWidget().buildSpacer(),
          if (oprovider.order.type == 1) ...[
            ScreenWidget().buildTitle('ข้อมูลคนขับ'),
            SizedBox(height: 1.h),
            buildRiderInformation(context, oprovider.order.riderid),
          ],
          SizedBox(height: 3.h),
          if (oprovider.order.status == 0) ...[
            managerAcceptButton(
                context, oprovider.order.id, oprovider.order.type),
          ] else if (oprovider.order.status == 2) ...[
            managerFinishButton(context, oprovider.order.id),
          ],
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget fragmentRiderDetail(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (_, oprovider, __) => Column(
        children: [
          ScreenWidget().buildTitle('ข้อมูลลูกค้า'),
          SizedBox(height: 1.h),
          buildCustomerInformation(context, oprovider.order.customerid),
          ScreenWidget().buildSpacer(),
          ScreenWidget().buildTitle('ข้อมูลที่อยู่ลูกค้า'),
          SizedBox(height: 1.h),
          buildUserAddress(context, oprovider.order.addressid),
          SizedBox(height: 3.h),
          if (oprovider.order.status == 1) ...[
            riderAcceptButton(context, oprovider.order.id),
          ] else if (oprovider.order.status == 3) ...[
            riderReceiveButton(context, oprovider.order.id),
          ] else if (oprovider.order.status == 4) ...[
            riderSendButton(context, oprovider.order.id),
          ],
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget fragmentCustomerDetail(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (_, oprovider, __) {
        return Column(
          children: [
            if (oprovider.order.type == 0) ...[
              ScreenWidget().buildTitle('ที่อยู่ที่ไปรับอาหาร'),
              SizedBox(height: 3.h),
              buildShopAddress(context),
              SizedBox(height: 1.h),
            ] else ...[
              ScreenWidget().buildTitle('ข้อมูลคนขับ'),
              SizedBox(height: 1.h),
              buildRiderInformation(context, oprovider.order.riderid),
              ScreenWidget().buildSpacer(),
              ScreenWidget().buildTitle('ที่อยู่ที่มาส่งอาหาร'),
              SizedBox(height: 1.h),
              buildUserAddress(context, oprovider.order.addressid),
              SizedBox(height: 2.h),
            ],
            if (oprovider.order.status == 5) ...[
              customerScoreButton(context, oprovider.order.id),
            ],
          ],
        );
      },
    );
  }

  Widget buildRiderInformation(BuildContext context, String riderid) {
    if (riderid != '') {
      Provider.of<UserProvider>(context, listen: false).readRiderById(riderid);
    }
    return Consumer<UserProvider>(
      builder: (_, uprovider, __) => SizedBox(
        width: 80.w,
        height: 10.h,
        child: ListTile(
          leading: riderid == ''
              ? Image.asset(MyImage.person)
              : ShowImage().showCircleImage(uprovider.rider.image),
          title: Row(
            children: [
              Text('ชื่อคนขับ  :  ', style: MyStyle().boldPrimary16()),
              riderid == ''
                  ? Text('ยังไม่มีคนขับรับงาน',
                      style: MyStyle().normalBlack16())
                  : Text(
                      '${uprovider.rider.firstname} ${uprovider.rider.lastname}',
                      style: MyStyle().normalBlack16())
            ],
          ),
          subtitle: Row(
            children: [
              Text('เบอร์โทร  :  ', style: MyStyle().boldPrimary16()),
              riderid == ''
                  ? Text('ยังไม่มีคนขับรับงาน',
                      style: MyStyle().normalBlack16())
                  : Text(uprovider.rider.phone,
                      style: MyStyle().normalBlack16()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomerInformation(BuildContext context, String customerid) {
    Provider.of<UserProvider>(context, listen: false)
        .readCustomerById(customerid);
    return Consumer<UserProvider>(
      builder: (_, uprovider, __) => SizedBox(
        width: 80.w,
        height: 10.h,
        child: ListTile(
          leading: uprovider.customer.image == ''
              ? Image.asset(MyImage.person)
              : ShowImage().showCircleImage(uprovider.customer.image),
          title: Row(
            children: [
              Text('ชื่อลูกค้า  :  ', style: MyStyle().boldPrimary16()),
              Text(
                  '${uprovider.customer.firstname} ${uprovider.customer.lastname}',
                  style: MyStyle().normalBlack16()),
            ],
          ),
          subtitle: Row(
            children: [
              Text('เบอร์โทร  :  ', style: MyStyle().boldPrimary16()),
              Text(uprovider.customer.phone, style: MyStyle().normalBlack16()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShopAddress(BuildContext context) {
    Provider.of<ShopProvider>(context, listen: false).readShopModel();
    return Consumer<ShopProvider>(
      builder: (_, sprovider, __) => Column(
        children: [
          SizedBox(
            width: 80.w,
            height: 30.h,
            child: ShowImage().showImage(sprovider.shop.image),
          ),
          SizedBox(height: 3.h),
          Text(sprovider.shop.name, style: MyStyle().boldBlue18()),
          SizedBox(height: 1.h),
          SizedBox(
            width: 60.w,
            child: Text(
              sprovider.shop.address,
              style: MyStyle().normalBlack16(),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 1.h),
          Text('เบอร์ติดต่อ : ${sprovider.shop.phone}',
              style: MyStyle().normalBlack16()),
        ],
      ),
    );
  }

  Widget buildUserAddress(BuildContext context, String addressid) {
    Provider.of<AddressProvider>(context, listen: false)
        .readAddressById(addressid);
    return Consumer<AddressProvider>(
      builder: (_, aprovider, __) => aprovider.address == null
          ? const ShowProgress()
          : Column(
              children: [
                Text(aprovider.address.name, style: MyStyle().boldBlue18()),
                Text(
                  aprovider.address.name == 'คอนโดถนอมมิตร'
                      ? 'ตึกหมายเลข ${aprovider.address.detail}'
                      : aprovider.address.detail,
                  style: MyStyle().normalBlack16(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
                ManagerProcess().acceptConfirmYes(context, orderId, type),
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
                ManagerProcess().acceptConfirmNo(context, orderId, type),
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
        onPressed: () => ManagerProcess().processFinishOrder(context, orderId),
        child: Text('ทำอาหารเสร็จสิ้น', style: MyStyle().normalWhite16()),
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
            onPressed: () => RiderProcess().acceptConfirmYes(context, orderId),
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
        onPressed: () => RiderProcess().processReceiveOrder(context, orderId),
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
        onPressed: () => RiderProcess().processSendOrder(context, orderId),
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
        child: Text('จัดส่งและชำระเงินเสร็จสิ้น',
            style: MyStyle().normalWhite16()),
      ),
    );
  }
}
