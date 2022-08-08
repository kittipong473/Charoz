import 'package:charoz/Component/User/Modal/edit_user.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .readUserById(MyVariable.userTokenId);
  }

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
                      if (MyVariable.role == 'customer') ...[
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
    return Consumer<UserProvider>(
      builder: (_, provider, __) => provider.user!.userImage == 'null'
          ? Image.asset(
              MyImage.person,
              width: 30.w,
              height: 30.w,
            )
          : ShowImage().showImage(provider.user!.userImage),
    );
  }

  Widget buildFirstName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ชื่อจริง : ',
          style: MyStyle().boldBlack18(),
        ),
        Consumer<UserProvider>(
          builder: (_, provider, __) => Text(
            provider.user!.userFirstName,
            style: MyStyle().normalPrimary18(),
          ),
        ),
      ],
    );
  }

  Widget buildLastName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'นามสกุล : ',
          style: MyStyle().boldBlack18(),
        ),
        Consumer<UserProvider>(
          builder: (_, provider, __) => Text(
            provider.user!.userLastName,
            style: MyStyle().normalPrimary18(),
          ),
        ),
      ],
    );
  }

  Widget buildEmail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'อีเมล : ',
          style: MyStyle().boldBlack18(),
        ),
        Consumer<UserProvider>(
          builder: (_, provider, __) => Text(
            provider.user!.userEmail,
            style: MyStyle().normalPrimary18(),
          ),
        ),
      ],
    );
  }

  Widget buildPhone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'เบอร์โทร : ',
          style: MyStyle().boldBlack18(),
        ),
        Consumer<UserProvider>(
          builder: (_, provider, __) => Text(
            provider.user!.userPhone,
            style: MyStyle().normalPrimary18(),
          ),
        ),
      ],
    );
  }

  Widget buildRole() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ตำแหน่ง : ',
          style: MyStyle().boldBlack18(),
        ),
        Consumer<UserProvider>(
          builder: (_, provider, __) => Text(
            provider.user!.userRole,
            style: MyStyle().normalPrimary18(),
          ),
        ),
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
          child: Consumer<UserProvider>(
            builder: (_, provider, __) => ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () =>
                  EditUser().openModalEditUser(context, provider.user),
              child: Text('แก้ไขข้อมูล', style: MyStyle().normalWhite16()),
            ),
          ),
        ),
        SizedBox(
          width: 35.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () => UserProvider().signOutFirebase(context),
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
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () =>
            Navigator.pushNamed(context, RoutePage.routeLocationList),
        child: Text('จัดการที่อยู่', style: MyStyle().normalWhite16()),
      ),
    );
  }
}
