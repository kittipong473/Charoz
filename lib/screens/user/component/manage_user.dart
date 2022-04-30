import 'package:animations/animations.dart';
import 'package:charoz/screens/user/model/user_model.dart';
import 'package:charoz/services/api/user_api.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:charoz/utils/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({Key? key}) : super(key: key);

  @override
  _ManageUserState createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  List<UserModel> users = [];
  bool load = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    users = await UserApi().getAllUser();
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: load
            ? const ShowProgress()
            : Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        SizedBox(
                          width: 100.w,
                          height: MyVariable.largeDevice ? 78.h : 73.h,
                          child: GridView.builder(
                            padding: MyVariable.largeDevice
                                ? const EdgeInsets.only(top: 10)
                                : const EdgeInsets.only(top: 0),
                            itemCount: users.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 2 / 3,
                                    maxCrossAxisExtent: 160),
                            itemBuilder: (context, index) {
                              return buildUserItem(users[index], index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyWidget().backgroundTitle(),
                  MyWidget().title('ผู้ใช้งานทั้งหมด'),
                ],
              ),
      ),
    );
  }

  Widget buildUserItem(UserModel user, int index) {
    return Card(
      color:
          user.userStatus != 'avaliable' ? Colors.grey.shade400 : Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => dialogUserDetail(context, user),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 25.w,
              height: 25.w,
              child: Image.asset(
                MyImage.person,
              ),
            ),
            Text(
              user.userPhone,
              style: MyStyle().boldPrimary14(),
            ),
            Text(
              user.userFirstName,
              style: MyStyle().boldBlack14(),
            ),
            Text(
              user.userRole,
              style: MyStyle().boldBlue14(),
            ),
          ],
        ),
      ),
    );
  }

  void dialogUserDetail(BuildContext context, UserModel user) {
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
              child: Image.asset(
                MyImage.person,
              ),
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
            Text(
              'สถานะ : ${user.userStatus}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
            Text(
              'วันที่สร้าง : ${user.created}',
              style: MyStyle().boldBlack16(),
            ),
            Text(
              'วันที่อัพเดท : ${user.updated}',
              style: MyStyle().boldBlack16(),
            ),
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
