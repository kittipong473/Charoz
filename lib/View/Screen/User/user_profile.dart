import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Model/Utility/my_variable.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Modal/edit_user.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final userVM = Get.find<UserViewModel>();

  @override
  void initState() {
    super.initState();
    userVM.getUserById(MyVariable.userTokenID!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(
          title: 'ข้อมูลผู้ใช้งาน',
          action: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_note_rounded, size: 35),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                SizedBox(height: 3.h),
                buildLogo(),
                SizedBox(height: 5.h),
                buildRole(),
                SizedBox(height: 3.h),
                buildName(),
                SizedBox(height: 3.h),
                buildPhone(),
                SizedBox(height: 3.h),
                buildEmail(),
                SizedBox(height: 3.h),
                buildCreate(),
                SizedBox(height: 3.h),
                buildUpdate(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return MyWidget()
        .showImage(path: MyImage.imgPerson, width: 40.w, height: 40.w);
  }

  Widget buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('ชื่อจริง : ',
            style: MyStyle.textStyle(size: 18, color: MyStyle.blackPrimary)),
        Text('${userVM.user!.firstname!} ${userVM.user!.lastname!}',
            style: MyStyle.textStyle(size: 18, color: MyStyle.orangePrimary)),
      ],
    );
  }

  Widget buildEmail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('อีเมล : ',
            style: MyStyle.textStyle(size: 18, color: MyStyle.blackPrimary)),
        Text(userVM.user!.email!,
            style: MyStyle.textStyle(size: 18, color: MyStyle.orangePrimary)),
      ],
    );
  }

  Widget buildPhone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('เบอร์โทร : ',
            style: MyStyle.textStyle(size: 18, color: MyStyle.blackPrimary)),
        Text(userVM.user!.phone!,
            style: MyStyle.textStyle(size: 18, color: MyStyle.orangePrimary)),
      ],
    );
  }

  Widget buildRole() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('ตำแหน่ง : ',
            style: MyStyle.textStyle(size: 18, color: MyStyle.blackPrimary)),
        Text(userVM.roleUserListTH[userVM.user!.role!],
            style: MyStyle.textStyle(size: 18, color: MyStyle.orangePrimary)),
      ],
    );
  }

  Widget buildCreate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('วันที่สร้าง : ',
            style: MyStyle.textStyle(size: 18, color: MyStyle.blackPrimary)),
        Text(MyFunction().getTimeAgo(time: userVM.user!.create!),
            style: MyStyle.textStyle(size: 18, color: MyStyle.orangePrimary)),
      ],
    );
  }

  Widget buildUpdate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('วันที่แก้ไข : ',
            style: MyStyle.textStyle(size: 18, color: MyStyle.blackPrimary)),
        Text(MyFunction().getTimeAgo(time: userVM.user!.update!),
            style: MyStyle.textStyle(size: 18, color: MyStyle.orangePrimary)),
      ],
    );
  }

  Widget buildButton() {
    return SizedBox(
      width: 35.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () => EditUser().openModalEditUser(context, userVM.user!),
        child: Text('แก้ไขข้อมูล',
            style: MyStyle.textStyle(size: 18, color: MyStyle.whitePrimary)),
      ),
    );
  }
}
