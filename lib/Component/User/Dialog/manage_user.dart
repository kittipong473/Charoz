import 'package:animations/animations.dart';
import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManageUser {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  void dialogManageUser(BuildContext context, UserModel user) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => SimpleDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: Image.asset(MyImage.person),
            ),
            const SizedBox(height: 20),
            Text(
              'เบอร์โทร : ${user.userPhone}',
              style: MyStyle().boldBlue18(),
            ),
            const SizedBox(height: 20),
            Text(
              'ชื่อ : ${user.userFirstName}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
            Text(
              'นามสกุล : ${user.userLastName}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
            Text(
              'วันเกิด : ${user.userBirth}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
            Text(
              'อีเมลล์ : ${user.userEmail}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
            Text(
              'ตำแหน่ง : ${user.userRole}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'เปลี่ยนสถานะ',
                  style: MyStyle().boldPrimary16(),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'ดูข้อมูลที่อยู่',
                  style: MyStyle().boldGreen16(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
