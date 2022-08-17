import 'package:charoz/Component/Notification/Dialog/noti_delete.dart';
import 'package:charoz/Component/Notification/Dialog/noti_detail.dart';
import 'package:charoz/Component/Notification/Modal/add_noti.dart';
import 'package:charoz/Model_Main/noti_model.dart';
import 'package:charoz/Provider/noti_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiList extends StatelessWidget {
  const NotiList({Key? key}) : super(key: key);

  Future getData(BuildContext context) async {
    await Provider.of<NotiProvider>(context, listen: false)
        .readNotiTypeList(MyVariable.notiTypeList[MyVariable.indexNotiChip]);
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              top: 2.h,
              child: StatefulBuilder(
                builder: (_, setState) => Column(
                  children: [
                    buildChip(context, setState),
                    buildNotiList(),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton:
            MyVariable.role == 'admin' || MyVariable.role == 'manager'
                ? FloatingActionButton(
                    onPressed: () => AddNoti().openModalAdNoti(context),
                    backgroundColor: MyStyle.bluePrimary,
                    child: Icon(Icons.add_alert_rounded,
                        size: 20.sp, color: Colors.white),
                  )
                : null,
      ),
    );
  }

  Widget buildChip(BuildContext context, Function setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < MyVariable.notiTypeList.length; i++) ...[
            chip(context, setState, MyVariable.notiTypeList[i], i),
          ],
        ],
      ),
    );
  }

  Widget chip(
      BuildContext context, Function setState, String title, int index) {
    return ActionChip(
      backgroundColor: MyVariable.indexNotiChip == index
          ? MyStyle.primary
          : Colors.grey.shade100,
      label: Text(
        title,
        style: MyVariable.indexNotiChip == index
            ? MyStyle().normalWhite16()
            : MyStyle().normalBlack16(),
      ),
      onPressed: () {
        setState(() => MyVariable.indexNotiChip = index);
        getData(context);
      },
    );
  }

  Widget buildNotiList() {
    return SizedBox(
      width: 100.w,
      height: 77.h,
      child: Consumer<NotiProvider>(
        builder: (_, provider, __) => provider.notiList == null
            ? const ShowProgress()
            : provider.notiList.isEmpty
                ? ScreenWidget().showEmptyData(
                    'ยังไม่มี ${MyVariable.notiTypeList[MyVariable.indexNotiChip]} ในขณะนี้',
                    'รอรายการ ${MyVariable.notiTypeList[MyVariable.indexNotiChip]} ในภายหลัง')
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 1.h),
                    itemCount: provider.notiList.length,
                    itemBuilder: (context, index) =>
                        buildNotiItem(context, provider.notiList[index], index),
                  ),
      ),
    );
  }

  Widget buildNotiItem(BuildContext context, NotiModel noti, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      elevation: 5.0,
      child: InkWell(
        onTap: () => NotiDetail().dialogNoti(context, noti),
        onLongPress: () => NotiDelete().confirmDelete(context, noti.id),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.campaign_rounded, size: 30.sp, color: MyStyle.primary),
              Text(noti.name, style: MyStyle().normalBlack16()),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: MyStyle.primary, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
