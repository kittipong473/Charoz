import 'package:animations/animations.dart';
import 'package:charoz/Model_Main/user_model.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Database/Firebase/user_crud.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      builder: (dialogContext) => SimpleDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.w,
              height: 30.w,
              child: Image.asset(MyImage.person),
            ),
            SizedBox(height: 1.h),
            Text('${user.firstname} ${user.lastname}',
                style: MyStyle().boldBlue18()),
            SizedBox(height: 3.h),
            Text('เบอร์โทรศัพท์ : ${user.phone}',
                style: MyStyle().normalBlack16()),
            SizedBox(height: 1.h),
            Text('อีเมลล์ : ${user.email}', style: MyStyle().normalBlack16()),
            SizedBox(height: 1.h),
            Text('ตำแหน่ง : ${user.role}', style: MyStyle().normalBlack16()),
          ],
        ),
        children: [
          TextButton(
            onPressed: () async {
              int? statusUser;
              if (user.status == 1) {
                statusUser = 0;
              } else if (user.status == 0) {
                statusUser = 1;
              }
              bool status =
                  await UserCRUD().updateUserStatus(user.id, statusUser!);
              if (status) {
                Provider.of<UserProvider>(context, listen: false)
                    .readUserList();
                MyFunction().toast('เปลี่ยนสถานะเรียบร้อย');
                Navigator.pop(context);
              } else {
                DialogAlert().doubleDialog(context, 'เปลี่ยนสถานะล้มเหลว',
                    'กรุณาลองใหม่อีกครั้งในภายหลัง');
              }
            },
            child: Text('เปลี่ยนสถานะ', style: MyStyle().boldPrimary16()),
          ),
        ],
      ),
    );
  }
}
