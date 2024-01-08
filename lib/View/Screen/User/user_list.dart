import 'package:charoz/Model/Api/FireStore/user_model.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final userVM = Get.find<UserViewModel>();

  @override
  void initState() {
    super.initState();
    userVM.readUserList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: GetBuilder<UserViewModel>(
          builder: (vm) => GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0),
            itemCount: userVM.userList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
            itemBuilder: (context, index) {
              return buildUserItem(context, userVM.userList[index], index);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(RoutePage.routeAddRider),
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
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: Image.asset(MyImage.imgPerson),
            ),
            Text(user.phone!,
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
            Text(user.role.toString(),
                style:
                    MyStyle.textStyle(size: 14, color: MyStyle.blackPrimary)),
            Text(user.status! ? 'อยู่ในระบบ' : 'ปิดการใช้งาน',
                style: MyStyle.textStyle(size: 14, color: MyStyle.bluePrimary)),
          ],
        ),
      ),
    );
  }
}
