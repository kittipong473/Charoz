import 'package:charoz/Component/User/Dialog/manage_user.dart';
import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              top: 8.h,
              child: Column(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 73.h,
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
                                    context, provider.userList[index], index);
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

  Widget buildUserItem(BuildContext context, UserModel user, int index) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => ManageUser().dialogManageUser(context, user),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 25.w,
              height: 25.w,
              child: user.userImage == 'null'
                  ? Image.asset(MyImage.person)
                  : ShowImage().showUser(user.userImage),
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
