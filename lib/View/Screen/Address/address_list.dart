import 'package:charoz/Model/Api/FireStore/address_model.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/Service/Firebase/address_crud.dart';
import 'package:charoz/View/Screen/Address/Modal/address_manage.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  final addVM = Get.find<AddressViewModel>();

  @override
  void initState() {
    super.initState();
    addVM.readAddressList();
  }

  @override
  void dispose() {
    addVM.clearAddressData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(title: 'ที่อยู่ทั้งหมดของฉัน'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: GetBuilder<AddressViewModel>(
            builder: (vm) => addVM.addressList.isEmpty
                ? MyWidget().showEmptyData(
                    title: 'ยังไม่มีข้อมูลที่อยู่',
                    body: 'กรุณาเพิ่มข้อมูลที่อยู่',
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 3.h),
                    shrinkWrap: true,
                    itemCount: addVM.addressList.length,
                    itemBuilder: (context, index) => Slidable(
                      startActionPane:
                          buildLeftSlidable(context, addVM.addressList[index]),
                      endActionPane:
                          buildRightSlidable(context, addVM.addressList[index]),
                      child: buildAddressItem(addVM.addressList[index], index),
                    ),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: MyStyle.bluePrimary,
            child: Icon(Icons.add_rounded, size: 20.sp, color: Colors.white),
            onPressed: () => AddressManage(context).modalAddAddress()),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.pin_drop_rounded,
                  color: MyStyle.bluePrimary,
                  size: 35,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addVM.datatypeAddress[address.type ?? 3],
                      style: MyStyle.textStyle(
                          size: 18, color: MyStyle.bluePrimary),
                    ),
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        address.detail!,
                        style: MyStyle.textStyle(
                            size: 14, color: MyStyle.blackPrimary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(Icons.compare_arrows_rounded,
                size: 25, color: MyStyle.orangePrimary),
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
          onTap: () =>
              AddressManage(context).modalEditAddress(address: address),
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
            bool status = await AddressCRUD().deleteAddress(id: address.id!);
            if (status) {
              addVM.readAddressList();
              ConsoleLog.toast(text: 'ลบข้อมูล ที่อยู่ เรียบร้อย');
            } else {
              DialogAlert(context).dialogApi();
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
