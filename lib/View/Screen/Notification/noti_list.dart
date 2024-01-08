import 'package:charoz/Model/Api/FireStore/noti_model.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Modal/add_noti.dart';
import 'package:charoz/View/Screen/Notification/Dialog/noti_detail.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/noti_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiList extends StatefulWidget {
  const NotiList({Key? key}) : super(key: key);

  @override
  State<NotiList> createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {
  final notiVM = Get.find<NotiViewModel>();
  final userVM = Get.find<UserViewModel>();

  int indexChip = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await notiVM.readNotiList();
    notiVM.getNotiTypeList(0);
    // initializeDateFormatting('th', '');
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              buildChip(),
              buildNotiList(),
            ],
          ),
        ),
        floatingActionButton: userVM.role == 4 || userVM.role == 3
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
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < notiVM.datatypeNotiType.length; i++) ...[
            chip(notiVM.datatypeNotiType[i], i),
          ],
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      elevation: 3,
      backgroundColor:
          indexChip == index ? MyStyle.orangePrimary : Colors.grey.shade100,
      label: Text(
        title,
        style: indexChip == index
            ? MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)
            : MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
      ),
      onPressed: () {
        setState(() => indexChip = index);
        notiVM.getNotiTypeList(index);
      },
    );
  }

  Widget buildNotiList() {
    return GetBuilder<NotiViewModel>(
      builder: (vm) => Expanded(
        child: vm.notiTypeList.isEmpty
            ? MyWidget().showEmptyData(
                title:
                    'ยังไม่มี ${notiVM.datatypeNotiType[indexChip]} ในขณะนี้',
                body:
                    'รอรายการ ${notiVM.datatypeNotiType[indexChip]} ในภายหลัง')
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
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [MyStyle.boxShadow()],
      ),
      child: InkWell(
        onTap: () {
          notiVM.setNotiModel(noti);
          NotiDetail(context).dialogNoti();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyWidget().showImage(
                  path: MyImage.lotShopAnnounce, width: 15.w, height: 15.w),
              Text(noti.name ?? '',
                  style:
                      MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: MyStyle.orangePrimary, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
