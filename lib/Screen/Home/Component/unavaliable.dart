import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Unavaliable extends StatefulWidget {
  const Unavaliable({Key? key}) : super(key: key);

  @override
  _UnavaliableState createState() => _UnavaliableState();
}

class _UnavaliableState extends State<Unavaliable> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.black45,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  MyImage.maintenance,
                  width: 80.w,
                  height: 40.w,
                ),
                const SizedBox(height: 30),
                Text(
                  'หน้านี้ยังไม่เปิดให้บริการ',
                  style: MyStyle().boldBlue20(),
                ),
                const SizedBox(height: 30),
                Text(
                  'รออัพเดทครั้งถัดไปจึงจะใช้บริการได้',
                  style: MyStyle().boldBlue20(),
                ),
                const SizedBox(height: 30),
                Text(
                  'ขออภัยในความไม่สะดวก',
                  style: MyStyle().boldBlue20(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
