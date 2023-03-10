import 'package:animations/animations.dart';
import 'package:charoz/Model/Data/user_model.dart';
import 'package:charoz/Service/Firebase/user_crud.dart';
import 'package:charoz/Model/Util/Constant/my_image.dart';
import 'package:charoz/Model/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManageUser {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  final UserViewModel userVM = Get.find<UserViewModel>();

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
              bool status =
                  await UserCRUD().updateUserStatus(user.id!, !user.status!);
              if (status) {
                userVM.readUserList();
                MyFunction().toast('เปลี่ยนสถานะเรียบร้อย');
                Get.back();
              } else {
                MyDialog(context).doubleDialog(
                    'เปลี่ยนสถานะล้มเหลว', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
              }
            },
            child: Text('เปลี่ยนสถานะ', style: MyStyle().boldPrimary16()),
          ),
        ],
      ),
    );
  }
}
