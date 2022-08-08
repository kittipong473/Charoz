import 'package:charoz/Component/User/Dialog/manage_user.dart';
import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    await Provider.of<UserProvider>(context, listen: false).readUserList();
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
              top: 3.h,
              child: Column(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 73.h,
                    child: Consumer<UserProvider>(
                      builder: (_, provider, __) => provider.userList == null
                          ? const ShowProgress()
                          : GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0),
                              itemCount: provider.userList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      childAspectRatio: 2 / 3,
                                      maxCrossAxisExtent: 160),
                              itemBuilder: (context, index) {
                                return buildUserItem(
                                    context, provider.userList[index], index);
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, RoutePage.routeAddRider),
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
              child: user.image == ''
                  ? Image.asset(MyImage.person)
                  : ShowImage().showImage(user.image),
            ),
            Text(user.phone, style: MyStyle().normalPrimary16()),
            Text(user.role, style: MyStyle().normalBlack14()),
            Text(user.status.toString(), style: MyStyle().normalBlack14()),
          ],
        ),
      ),
    );
  }
}
