import 'package:charoz/View/Modal/edit_user.dart';
import 'package:charoz/Service/Initial/route_page.dart';
import 'package:charoz/Model/Util/Constant/my_image.dart';
import 'package:charoz/Model/Util/Constant/my_style.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_image.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final UserViewModel userVM = Get.find<UserViewModel>();

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  void getData() async {
    await userVM.getUserById(VariableGeneral.userTokenId!);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      buildImage(),
                      SizedBox(height: 3.h),
                      buildFirstName(),
                      SizedBox(height: 3.h),
                      buildLastName(),
                      SizedBox(height: 3.h),
                      buildEmail(),
                      SizedBox(height: 3.h),
                      buildPhone(),
                      SizedBox(height: 3.h),
                      buildRole(),
                      SizedBox(height: 5.h),
                      buildButton(context),
                      if (VariableGeneral.role == 'customer') ...[
                        SizedBox(height: 5.h),
                        buildUserLocation(context),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            ScreenWidget().appBarTitle('ข้อมูลผู้ใช้งาน'),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return userVM.user!.userImage == 'null'
        ? Image.asset(MyImage.person, width: 30.w, height: 30.w)
        : ShowImage().showImage(userVM.user!.userImage, BoxFit.cover);
  }

  Widget buildFirstName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('ชื่อจริง : ', style: MyStyle().boldBlack18()),
        Text(userVM.user!.userFirstName, style: MyStyle().normalPrimary18()),
      ],
    );
  }

  Widget buildLastName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('นามสกุล : ', style: MyStyle().boldBlack18()),
        Text(userVM.user!.userLastName, style: MyStyle().normalPrimary18()),
      ],
    );
  }

  Widget buildEmail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('อีเมล : ', style: MyStyle().boldBlack18()),
        Text(userVM.user!.userEmail, style: MyStyle().normalPrimary18()),
      ],
    );
  }

  Widget buildPhone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('เบอร์โทร : ', style: MyStyle().boldBlack18()),
        Text(userVM.user!.userPhone, style: MyStyle().normalPrimary18()),
      ],
    );
  }

  Widget buildRole() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('ตำแหน่ง : ', style: MyStyle().boldBlack18()),
        Text(userVM.user!.userRole, style: MyStyle().normalPrimary18()),
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 35.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () => EditUser().openModalEditUser(context, userVM.user),
            child: Text('แก้ไขข้อมูล', style: MyStyle().normalWhite16()),
          ),
        ),
        SizedBox(
          width: 35.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // userVM.signOutFirebase(context);
            },
            child: Text('ลงชื่อออก', style: MyStyle().normalWhite16()),
          ),
        ),
      ],
    );
  }

  Widget buildUserLocation(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () =>
            Navigator.pushNamed(context, RoutePage.routeLocationList),
        child: Text('จัดการที่อยู่', style: MyStyle().normalWhite16()),
      ),
    );
  }
}
