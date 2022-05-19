import 'package:badges/badges.dart';
import 'package:charoz/Screen/Notification/Component/Section/news.dart';
import 'package:charoz/Screen/Notification/Component/Section/others.dart';
import 'package:charoz/Screen/Notification/Component/Section/promo.dart';
import 'package:charoz/Screen/Notification/Provider/noti_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiCustomer extends StatefulWidget {
  const NotiCustomer({Key? key}) : super(key: key);

  @override
  _NotiCustomerState createState() => _NotiCustomerState();
}

class _NotiCustomerState extends State<NotiCustomer> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotiProvider>(context, listen: false).getAllNoti();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<NotiProvider>(
          builder: (context, nprovider, child) => Stack(
            children: [
              Positioned.fill(
                top: 10.h,
                child: Column(
                  children: [
                    buildChip(nprovider),
                    SizedBox(
                      width: 100.w,
                      height: 76.h,
                      child: setPage(MyVariable.notiCustomerIndex, nprovider),
                    ),
                  ],
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('การแจ้งเตือน'),
              if (MyVariable.role == "admin") ...[
                MyWidget().createNoti(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChip(NotiProvider nprovider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          chip('โปรโมชั่น', 0, nprovider.notiPromosLength),
          chip('ข่าวสาร', 1, nprovider.notiNewsLength),
          chip('อื่นๆ', 2, 1),
        ],
      ),
    );
  }

  Widget chip(String title, int index, int length) {
    return Badge(
      badgeContent: Text(
        length.toString(),
        style: MyStyle().boldWhite14(),
      ),
      badgeColor: Colors.blue,
      padding: const EdgeInsets.all(8),
      child: ActionChip(
        backgroundColor: MyVariable.notiCustomerIndex == index
            ? MyStyle.primary
            : Colors.grey.shade300,
        label: Text(
          title,
          style: MyVariable.notiCustomerIndex == index
              ? MyStyle().boldWhite14()
              : MyStyle().boldBlack14(),
        ),
        onPressed: () {
          setState(() {
            MyVariable.notiCustomerIndex = index;
          });
        },
      ),
    );
  }

  Widget setPage(int indexPage, NotiProvider nprovider) {
    List<Widget> pages = [
      Promo(notiPromos: nprovider.notiPromos),
      News(notiNews: nprovider.notiNews),
      const Others(),
    ];
    return pages[indexPage];
  }
}
