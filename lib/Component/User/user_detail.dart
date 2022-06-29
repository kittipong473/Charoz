import 'package:charoz/Component/User/edit_user.dart';
import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<UserProvider>(
          builder: (context, uprovider, child) => Stack(
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
                        buildImage(),
                        SizedBox(height: 3.h),
                        buildFirstName(uprovider.user!.userFirstName),
                        SizedBox(height: 3.h),
                        buildLastName(uprovider.user!.userLastName),
                        SizedBox(height: 3.h),
                        buildEmail(uprovider.user!.userEmail),
                        SizedBox(height: 3.h),
                        buildPhone(uprovider.user!.userPhone),
                        SizedBox(height: 3.h),
                        buildBirth(MyFunction()
                            .convertBirthTime(uprovider.user!.userBirth)),
                        SizedBox(height: 3.h),
                        buildRole(uprovider.user!.userRole),
                        SizedBox(height: 5.h),
                        buildButton(context, uprovider.user),
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
      ),
    );
  }

  Widget buildImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          MyImage.person,
          width: 30.w,
          height: 30.w,
        ),
      ],
    );
  }

  Widget buildFirstName(String fname) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ชื่อจริง : ',
          style: MyStyle().boldBlack18(),
        ),
        Text(
          fname,
          style: MyStyle().normalPrimary18(),
        ),
      ],
    );
  }

  Widget buildLastName(String lname) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'นามสกุล : ',
          style: MyStyle().boldBlack18(),
        ),
        Text(
          lname,
          style: MyStyle().normalPrimary18(),
        ),
      ],
    );
  }

  Widget buildEmail(String email) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'อีเมล : ',
          style: MyStyle().boldBlack18(),
        ),
        Text(
          email,
          style: MyStyle().normalPrimary18(),
        ),
      ],
    );
  }

  Widget buildPhone(String phone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'เบอร์โทร : ',
          style: MyStyle().boldBlack18(),
        ),
        Text(
          phone,
          style: MyStyle().normalPrimary18(),
        ),
      ],
    );
  }

  Widget buildBirth(String birth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'วันเดือนปีเกิด : ',
          style: MyStyle().boldBlack18(),
        ),
        Text(
          birth,
          style: MyStyle().normalPrimary18(),
        ),
      ],
    );
  }

  Widget buildRole(String role) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ตำแหน่ง : ',
          style: MyStyle().boldBlack18(),
        ),
        Text(
          role,
          style: MyStyle().normalPrimary18(),
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context, UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 35.w,
          height: MyVariable.largeDevice ? 60 : 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUser(
                    user: user,
                  ),
                ),
              );
            },
            child: Text(
              'แก้ไขข้อมูล',
              style: MyStyle().boldWhite16(),
            ),
          ),
        ),
        SizedBox(
          width: 35.w,
          height: MyVariable.largeDevice ? 60 : 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () => UserProvider().signOutFirebase(context),
            child: Text(
              'ลงชื่อออก',
              style: MyStyle().boldWhite16(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUserLocation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: MyVariable.largeDevice ? 60 : 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
            onPressed: () =>
                Navigator.pushNamed(context, RoutePage.routeLocationList),
            child: Text(
              'จัดการที่อยู่',
              style: MyStyle().boldWhite16(),
            ),
          ),
        ),
      ],
    );
  }
}
