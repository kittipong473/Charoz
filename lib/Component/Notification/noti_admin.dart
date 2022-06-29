import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Provider/noti_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_detail.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiAdmin extends StatefulWidget {
  const NotiAdmin({Key? key}) : super(key: key);

  @override
  State<NotiAdmin> createState() => _NotiAdminState();
}

class _NotiAdminState extends State<NotiAdmin> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    Provider.of<NotiProvider>(context, listen: false)
        .getAllNotiWhereType(MyVariable.notisAdmin[MyVariable.indexNotiChip]);
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
              top: 8.h,
              child: RefreshIndicator(
                onRefresh: getData,
                child: Column(
                  children: [
                    buildChip(),
                    buildNotiList(),
                  ],
                ),
              ),
            ),
            ScreenWidget().appBarTitle('การแจ้งเตือน'),
            ScreenWidget().createNoti(context),
          ],
        ),
      ),
    );
  }

  Widget buildChip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          chip(MyVariable.notisAdmin[0], 0),
          chip(MyVariable.notisAdmin[1], 1),
          chip(MyVariable.notisAdmin[2], 2),
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      backgroundColor: MyVariable.indexNotiChip == index
          ? MyStyle.primary
          : Colors.grey.shade300,
      label: Text(
        title,
        style: MyVariable.indexNotiChip == index
            ? MyStyle().normalWhite16()
            : MyStyle().normalBlack16(),
      ),
      onPressed: () {
        setState(() => MyVariable.indexNotiChip = index);
        getData();
      },
    );
  }

  Widget buildNotiList() {
    return SizedBox(
      width: 100.w,
      height: 70.h,
      child: Consumer<NotiProvider>(
        builder: (_, provider, __) => provider.notificateList == null
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ยังไม่มี ${MyVariable.notisAdmin[MyVariable.indexNotiChip]} ในขณะนี้',
                      style: MyStyle().normalPrimary18(),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'กรุณารอรายการ ${MyVariable.notisAdmin[MyVariable.indexNotiChip]} ได้ในภายหลัง',
                      style: MyStyle().normalPrimary18(),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                itemCount: provider.notificateList.length,
                itemBuilder: (context, index) {
                  return buildNotiItem(provider.notificateList[index], index);
                },
              ),
      ),
    );
  }

  Widget buildNotiItem(NotiModel noti, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 5.0,
      child: InkWell(
        onTap: () => DialogDetail().dialogNoti(context, noti),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.campaign_rounded, size: 30.sp, color: MyStyle.primary),
              Text(noti.notiName, style: MyStyle().normalBlack16()),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: MyStyle.primary, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
