import 'package:charoz/Model/Api/FireStore/address_model.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/View/Screen/Address/Modal/address_manage.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectAddress {
  final AddressViewModel addVM = Get.find<AddressViewModel>();

  Future<dynamic> openModalSelectAddress(context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) => modalSelectAddress(context));

  Widget modalSelectAddress(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 50.h,
      child: Stack(
        children: [
          if (addVM.addressList.isEmpty) ...[
            MyWidget().showEmptyData(
                title: 'ยังไม่มีข้อมูลที่อยู่', body: 'กรุณาเพิ่มข้อมูลที่อยู่')
          ] else ...[
            Positioned.fill(
              top: 5.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 45.h,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        shrinkWrap: true,
                        itemCount: addVM.addressList.length,
                        itemBuilder: (context, index) => buildAddressItem(
                            context, addVM.addressList[index], index),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          MyWidget().buildModalHeader(title: 'เลือกที่อยู่จัดส่งของคุณ'),
          Positioned(
            top: -1.h,
            right: 3.w,
            child: IconButton(
              onPressed: () => AddressManage(context).modalAddAddress(),
              icon: Icon(
                Icons.add_circle_rounded,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddressItem(
      BuildContext context, AddressModel address, int index) {
    return InkWell(
      onTap: () {
        addVM.selectAddressWhereId(address.id!);
        ConsoleLog.toast(text: 'เปลี่ยนที่อยู่จัดส่งเรียบร้อย');
        Get.back();
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 1.h),
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.pin_drop_rounded,
                color: MyStyle.bluePrimary,
                size: 25.sp,
              ),
              Column(
                children: [
                  Text(
                    address.type.toString(),
                    style:
                        MyStyle.textStyle(size: 16, color: MyStyle.bluePrimary),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        address.type.toString() == 'คอนโดถนอมมิตร'
                            ? 'ตึกหมายเลข ${address.detail}'
                            : address.detail!,
                        style: MyStyle.textStyle(
                            size: 14, color: MyStyle.blackPrimary),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.check_circle_rounded,
                  size: 25.sp, color: MyStyle.orangePrimary),
            ],
          ),
        ),
      ),
    );
  }
}
