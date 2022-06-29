import 'package:animations/animations.dart';
import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_detail.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getAllUser();
    super.initState();
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
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  SizedBox(
                    width: 100.w,
                    height: MyVariable.largeDevice ? 78.h : 73.h,
                    child: Consumer<UserProvider>(
                      builder: (_, provider, __) => provider.userList == null
                          ? const ShowProgress()
                          : GridView.builder(
                              padding: const EdgeInsets.only(top: 0),
                              itemCount: provider.userList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      childAspectRatio: 2 / 3,
                                      maxCrossAxisExtent: 160),
                              itemBuilder: (context, index) {
                                return buildUserItem(
                                    provider.userList[index], index);
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
            ScreenWidget().appBarTitle('ผู้ใช้งานทั้งหมด'),
          ],
        ),
      ),
    );
  }

  Widget buildUserItem(UserModel user, int index) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => DialogDetail().dialogUserDetail(context, user),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 25.w,
              height: 25.w,
              child: Image.asset(MyImage.person),
            ),
            Text(user.userPhone, style: MyStyle().normalPrimary14()),
            Text(user.userFirstName, style: MyStyle().normalBlack14()),
            Text(user.userRole, style: MyStyle().normalBlue14()),
          ],
        ),
      ),
    );
  }
}
