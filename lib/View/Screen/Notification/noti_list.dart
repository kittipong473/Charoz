import 'package:charoz/View/Dialog/noti_delete.dart';
import 'package:charoz/View/Dialog/noti_detail.dart';
import 'package:charoz/View/Modal/add_noti.dart';
import 'package:charoz/Model/Data/noti_model.dart';
import 'package:charoz/Util/Constant/my_image.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View_Model/noti_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final NotiViewModel notiVM = Get.find<NotiViewModel>();

class NotiList extends StatelessWidget {
  const NotiList({Key? key}) : super(key: key);

  void getData(BuildContext context) {
    notiVM.readNotiTypeList(
        VariableData.notiTypeList[VariableGeneral.indexNotiChip]);
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
            VariableGeneral.role == 'admin' || VariableGeneral.role == 'manager'
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
          for (var i = 0; i < VariableData.notiTypeList.length; i++) ...[
            chip(context, setState, VariableData.notiTypeList[i], i),
          ],
        ],
      ),
    );
  }

  Widget chip(
      BuildContext context, Function setState, String title, int index) {
    return ActionChip(
      backgroundColor: VariableGeneral.indexNotiChip == index
          ? MyStyle.primary
          : Colors.grey.shade100,
      label: Text(
        title,
        style: VariableGeneral.indexNotiChip == index
            ? MyStyle().normalWhite16()
            : MyStyle().normalBlack16(),
      ),
      onPressed: () {
        setState(() => VariableGeneral.indexNotiChip = index);
        getData(context);
      },
    );
  }

  Widget buildNotiList() {
    return SizedBox(
      width: 100.w,
      height: 77.h,
      child: notiVM.notiList.isEmpty
          ? ScreenWidget().showEmptyData(
              'ยังไม่มี ${VariableData.notiTypeList[VariableGeneral.indexNotiChip]} ในขณะนี้',
              'รอรายการ ${VariableData.notiTypeList[VariableGeneral.indexNotiChip]} ในภายหลัง')
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 1.h),
              itemCount: notiVM.notiList.length,
              itemBuilder: (context, index) =>
                  buildNotiItem(context, notiVM.notiList[index], index),
            ),
    );
  }

  Widget buildNotiItem(BuildContext context, NotiModel noti, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      elevation: 5.0,
      child: InkWell(
        onTap: () => NotiDetail().dialogNoti(context, noti),
        onLongPress: () => NotiDelete(context, noti.id).confirmDelete(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Lottie.asset(MyImage.gifShopAnnounce, width: 15.w, height: 15.w),
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
