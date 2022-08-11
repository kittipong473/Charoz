import 'package:charoz/Model_Main/order_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Service/Database/Firebase/order_crud.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RiderWorking extends StatefulWidget {
  const RiderWorking({Key? key}) : super(key: key);

  @override
  State<RiderWorking> createState() => _RiderWorkingState();
}

class _RiderWorkingState extends State<RiderWorking> {
  Color themeItem = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              top: 2.h,
              child: Column(
                children: [buildOrderList()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderList() {
    return SizedBox(
      width: 100.w,
      height: 77.h,
      child: Consumer<OrderProvider>(
        builder: (_, provider, __) => provider.orderList == null
            ? const ShowProgress()
            : provider.orderList.isEmpty
                ? ScreenWidget().showEmptyData(
                    'ยังไม่มี ออเดอร์ที่ต้องจัดส่ง ในขณะนี้',
                    'สามารถกดรับออเดอร์ได้จากหน้าแรก เมื่อมีลูกค้าสั่งอาหาร')
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 1.h),
                    itemCount: provider.orderList.length,
                    itemBuilder: (context, index) =>
                        buildOrderItem(provider.orderList[index], index),
                  ),
      ),
    );
  }

  Widget buildOrderItem(OrderModel order, int index) {
    return Card(
      // margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      // color: themeItem,
      // elevation: 5.0,
      // child: InkWell(
      //   onTap: () {
      //     Provider.of<OrderProvider>(context, listen: false)
      //         .selectOrderWhereId(order.id);
      //     Navigator.pushNamed(context, RoutePage.routeOrderDetail);
      //   },
      //   child: Padding(
      //     padding: EdgeInsets.all(15.sp),
      //     child: Consumer3<ShopProvider, UserProvider, AddressProvider>(
      //       builder: (_, sprovider, uprovider, aprovider, __) => Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               orderStatusStream(index),
      //               // Text(MyVariable.orderStatusList[order.status],
      //               //     style: MyStyle().boldPrimary18()),
      //               Text(MyFunction().convertToDateTime(order.time),
      //                   style: MyStyle().normalBlack14()),
      //             ],
      //           ),
      //           ScreenWidget().buildSpacer(),
      //           fragmentRiderDetail(order)
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  // StreamBuilder orderStatusStream(int index) {
  //   return StreamBuilder(
  //     stream: OrderCRUD().readStatusOrderListStream(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('ไม่พบข้อมูล', style: MyStyle().boldPrimary18());
  //       } else if (snapshot.hasData) {
  //         List<OrderModel> orderNameList = snapshot.data!;
  //         orderNameList.sort((a, b) => b.time.compareTo(a.time));
  //         return Text(MyVariable.orderStatusList[orderNameList[index].status],
  //             style: MyStyle().boldPrimary18());
  //       } else {
  //         return const ShowProgress();
  //       }
  //     },
  //   );
  // }
}
