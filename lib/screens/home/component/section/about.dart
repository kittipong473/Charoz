import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: MyVariable.largeDevice
                      ? const EdgeInsets.symmetric(horizontal: 40)
                      : const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      for (var i = 0; i < MyVariable.aboutQues.length; i++) ...[
                        buildQuestion(MyVariable.aboutQues[i]),
                        SizedBox(height: 1.h),
                        buildAnswer(MyVariable.aboutAns[i]),
                        SizedBox(height: 3.h),
                      ],
                      SizedBox(height: 3.h),
                      buildContact(),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ),
            MyWidget().backgroundTitle(),
            MyWidget().title('ข้อมูลร้านค้า'),
            MyWidget().backPage(context),
          ],
        ),
      ),
    );
  }

  Widget buildQuestion(String text) {
    return SizedBox(
      width: 90.w,
      child: Text(
        text,
        style: MyStyle().boldBlue18(),
      ),
    );
  }

  Widget buildAnswer(String text) {
    return SizedBox(
      width: 90.w,
      child: Text(
        text,
        style: MyStyle().normalPrimary16(),
      ),
    );
  }

  Widget buildContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'เนื่องจาก Application นี้พึ่งเปิดบริการ จึงอาจจะมีบัคหรือบางส่วนที่ทำงานไม่ได้ สามารถแจ้งข้อผิดพลาดได้ที่ผู้ดูแลระบบ หรือ ผู้จัดการร้าน',
            style: MyStyle().boldBlue16(),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'เบอร์โทรติดต่อ : ',
                style: MyStyle().boldBlack18(),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ผู้จัดการร้าน : ',
                style: MyStyle().boldBlack16(),
              ),
              Text(
                'ณัฐพงษ์ 097-1649261',
                style: MyStyle().normalPrimary16(),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ผู้ดูแลระบบ : ',
                style: MyStyle().boldBlack16(),
              ),
              Text(
                'กิตติพงศ์ 095-6492669',
                style: MyStyle().normalPrimary16(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
