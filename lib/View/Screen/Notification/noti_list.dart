import 'package:charoz/Model/Api/FireStore/noti_model.dart';
import 'package:charoz/View/Dialog/noti_delete.dart';
import 'package:charoz/View/Modal/modal_noti.dart';
import 'package:charoz/View/Modal/add_noti.dart';
import 'package:charoz/Utility/Constant/my_image.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/Utility/Variable/var_data.dart';
import 'package:charoz/Utility/Variable/var_general.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View_Model/noti_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiList extends StatefulWidget {
  const NotiList({Key? key}) : super(key: key);

  @override
  State<NotiList> createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {
  final NotiViewModel notiVM = Get.find<NotiViewModel>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await notiVM.readNotiList();
    notiVM.getNotiTypeList(0);
  }

  @override
  void dispose() {
    notiVM.clearNotiData();
    super.dispose();
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
              top: 2.h,
              child: StatefulBuilder(
                builder: (_, setState) => Column(
                  children: [
                    buildChip(),
                    buildNotiList(),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton:
            VariableGeneral.role == 0 || VariableGeneral.role == 3
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

  Widget buildChip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < VariableData.datatypeNotiType.length; i++) ...[
            chip(VariableData.datatypeNotiType[i], i),
          ],
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      backgroundColor: VariableGeneral.indexNotiChip == index
          ? MyStyle.orangePrimary
          : Colors.grey.shade100,
      label: Text(
        title,
        style: VariableGeneral.indexNotiChip == index
            ? MyStyle().normalWhite16()
            : MyStyle().normalBlack16(),
      ),
      onPressed: () {
        setState(() => VariableGeneral.indexNotiChip = index);
        notiVM.getNotiTypeList(index);
      },
    );
  }

  Widget buildNotiList() {
    return GetBuilder<NotiViewModel>(
      builder: (vm) => SizedBox(
        width: 100.w,
        height: 77.h,
        child: vm.notiTypeList.isEmpty
            ? ScreenWidget().showEmptyData(
                'ยังไม่มี ${VariableData.datatypeNotiType[VariableGeneral.indexNotiChip]} ในขณะนี้',
                'รอรายการ ${VariableData.datatypeNotiType[VariableGeneral.indexNotiChip]} ในภายหลัง')
            : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 1.h),
                itemCount: vm.notiTypeList.length,
                itemBuilder: (context, index) =>
                    buildNotiItem(vm.notiTypeList[index]),
              ),
      ),
    );
  }

  Widget buildNotiItem(NotiModel noti) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          notiVM.setNotiModel(noti);
          ModalNoti().dialogNoti(context);
        },
        onLongPress: () => NotiDelete(context, noti.id!).confirmDelete(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Lottie.asset(MyImage.gifShopAnnounce, width: 15.w, height: 15.w),
              Text(noti.name ?? '', style: MyStyle().normalBlack16()),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: MyStyle.orangePrimary, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
