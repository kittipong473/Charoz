import 'package:charoz/screens/noti/provider/noti_provider.dart';
import 'package:charoz/utils/constant/my_style.dart';
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
            builder: (context, pprovider, child) => Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'หน้านี้ยังไม่เปิดให้บริการ',
                        style: MyStyle().boldPrimary20(),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'กรุณารอติดตามได้ในภายหลัง',
                        style: MyStyle().boldPrimary20(),
                      ),
                    ],
                  ),
                )),
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

  // Widget buildPromotionItem(index) {
  //   return Card(
  //     margin: const EdgeInsets.all(10),
  //     elevation: 5.0,
  //     child: InkWell(
  //       onTap: () {},
  //       child: Padding(
  //         padding: MyVariable.largeDevice
  //             ? const EdgeInsets.all(20)
  //             : const EdgeInsets.all(10),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Icon(
  //               Icons.campaign_rounded,
  //               size: 20.sp,
  //               color: MyStyle.primary,
  //             ),
  //             Text(
  //               'item $index',
  //               style: MyStyle().boldBlack16(),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
