import 'package:charoz/services/route/route_page.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildImage(),
              SizedBox(height: 5.h),
              Text(
                'ขอบคุณที่ช่วยกรอกแบบประเมินความพึงพอใจ',
                style: MyStyle().boldBlack18(),
              ),
              SizedBox(height: 1.h),
              Text(
                'ทางเราจะนำไปพัฒนาร้านค้าให้ดียิ่งขึ้นต่อไป...',
                style: MyStyle().boldBlack18(),
              ),
              SizedBox(height: 3.h),
              buildButton(context),
              SizedBox(height: 3.h),
              buildFuture(),
              buildLottie(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Image.asset(
      MyImage.logo2,
      width: 40.w,
      height: 40.w,
    );
  }

  Row buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: MyVariable.largeDevice ? 60 : 40,
          child: TextButton(
            onPressed: () {
              MyVariable.chooseJob = '--เลือกอาชีพ--';
              MyVariable.indexPage = 0;
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutePage.routeHomeService, (route) => false);
            },
            child: Text(
              'กลับไปหน้าหลัก',
              style: MyStyle().boldPrimary18(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFuture() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'เตรียมพบกับการสั่งอาหารผ่านแอพพลิเคชั่น "CharoZ Steak House"\nได้ในเร็วๆนี้',
          style: MyStyle().boldBlue14(),
        ),
      ],
    );
  }

  Widget buildLottie() {
    return Lottie.asset(MyImage.gifSuggest,width: 60.sp,height: 60.sp);
  }
}
