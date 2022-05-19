import 'package:charoz/Screen/Notification/Provider/noti_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Others extends StatefulWidget {
  const Others({Key? key}) : super(key: key);

  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<NotiProvider>(
          builder: (context, pprovider, child) => ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => buildOthersItem(index),
          ),
          // Center(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             'หน้านี้ยังไม่เปิดให้บริการ',
          //             style: MyStyle().boldPrimary20(),
          //           ),
          //           SizedBox(height: 3.h),
          //           Text(
          //             'กรุณารอติดตามได้ในภายหลัง',
          //             style: MyStyle().boldPrimary20(),
          //           ),
          //         ],
          //       ),
          //     )),
        ),
      ),
    );
  }
  //   return SafeArea(
  //     top: false,
  //     child: Scaffold(
  //       backgroundColor: MyStyle.colorBackGround,
  //       body: Consumer<NotiProvider>(
  //         builder: (context, pprovider, child) => ListView.builder(
  //           itemCount: 50,
  //           itemBuilder: (context, index) =>
  //               buildPromotionItem(index),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildOthersItem(index) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5.0,
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, RoutePage.routeQuestionAnswer),
        child: Padding(
          padding: MyVariable.largeDevice
              ? const EdgeInsets.all(20)
              : const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.receipt_outlined,
                size: 30.sp,
                color: MyStyle.primary,
              ),
              Text(
                'คำถามที่เกี่ยวข้อง ?',
                style: MyStyle().boldBlack16(),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: MyStyle.primary,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
