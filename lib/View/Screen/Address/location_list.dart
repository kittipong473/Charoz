import 'package:charoz/View/Modal/add_location.dart';
import 'package:charoz/View/Modal/edit_location.dart';
import 'package:charoz/Model/Data/address_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/address_crud.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final AddressViewModel addVM = Get.find<AddressViewModel>();

class LocationList extends StatelessWidget {
  const LocationList({Key? key}) : super(key: key);

  void getData() {
    addVM.readAddressList();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('ที่อยู่ทั้งหมดของฉัน'),
        body: Stack(
          children: [
            if (addVM.addressList == null) ...[
              ScreenWidget().showEmptyData(
                  'ยังไม่มีข้อมูลที่อยู่', 'กรุณาเพิ่มข้อมูลที่อยู่')
            ] else ...[
              Positioned.fill(
                top: 2.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 80.h,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 0),
                          shrinkWrap: true,
                          itemCount: addVM.addressList.length,
                          itemBuilder: (context, index) => Slidable(
                            startActionPane: buildLeftSlidable(
                                context, addVM.addressList[index]),
                            endActionPane: buildRightSlidable(
                                context, addVM.addressList[index]),
                            child: buildAddressItem(
                                addVM.addressList[index], index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: MyStyle.bluePrimary,
            child: Icon(Icons.add_rounded, size: 20.sp, color: Colors.white),
            onPressed: () => AddLocation().openModalAddAddress(context)),
      ),
    );
  }

  Widget buildAddressItem(AddressModel address, int index) {
    return Card(
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
                Text(address.type.toString(), style: MyStyle().normalBlue16()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        address.type.toString() == 'คอนโดถนอมมิตร'
                            ? 'ตึกหมายเลข ${address.detail}'
                            : address.detail,
                        style: MyStyle().normalBlack14()),
                  ],
                ),
              ],
            ),
            Icon(Icons.compare_arrows_rounded,
                size: 20.sp, color: MyStyle.primary),
          ],
        ),
      ),
    );
  }

  ActionPane buildLeftSlidable(BuildContext context, AddressModel address) {
    return ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 0.2,
      children: [
        InkWell(
          onTap: () => EditLocation().openModalEditAddress(context, address),
          child: Container(
            width: 10.w,
            height: 10.w,
            margin: EdgeInsets.only(left: 5.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              Icons.edit_location_alt_rounded,
              size: 20.sp,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  ActionPane buildRightSlidable(BuildContext context, AddressModel address) {
    return ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 0.2,
      children: [
        InkWell(
          onTap: () async {
            bool status = await AddressCRUD().deleteAddress(address.id);
            if (status) {
              MyFunction().toast('ลบที่อยู่เรียบร้อยแล้ว');
            } else {
              MyDialog(context).deleteFailedDialog();
            }
          },
          child: Container(
            width: 10.w,
            height: 10.w,
            margin: EdgeInsets.only(left: 5.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              Icons.delete_forever_rounded,
              size: 20.sp,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
