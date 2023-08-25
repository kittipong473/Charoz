import 'package:charoz/Model/Api/FireStore/user_model.dart';
import 'package:charoz/View/Dialog/manage_user.dart';
import 'package:charoz/Service/Initial/route_page.dart';
import 'package:charoz/Utility/Constant/my_image.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final UserViewModel userVM = Get.find<UserViewModel>();

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  void getData() async {
    await userVM.readUserList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: Stack(
          children: [
            Positioned.fill(
              top: 3.h,
              child: Column(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 73.h,
                    child: GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 0),
                      itemCount: userVM.userList.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
                      itemBuilder: (context, index) {
                        return buildUserItem(
                            context, userVM.userList[index], index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.pushNamed(context, RoutePage.routeAddRider),
          backgroundColor: MyStyle.bluePrimary,
          child: Icon(
            Icons.person_add_rounded,
            size: 20.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildUserItem(BuildContext context, UserModel user, int index) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.all(10.sp),
      child: InkWell(
        onTap: () => ManageUser().dialogManageUser(context, user),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: Image.asset(MyImage.person),
            ),
            Text(user.phone!, style: MyStyle().normalPrimary16()),
            Text(user.role.toString(), style: MyStyle().normalBlack14()),
            Text(user.status! ? 'อยู่ในระบบ' : 'ปิดการใช้งาน',
                style: MyStyle().normalBlue14()),
          ],
        ),
      ),
    );
  }
}
