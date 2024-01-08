import 'package:charoz/Model/Api/FireStore/address_model.dart';
import 'package:charoz/Model/Api/Modify/address_modify.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Model/Utility/my_variable.dart';
import 'package:charoz/Service/Firebase/address_crud.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddressManage {
  final BuildContext context;
  AddressManage(this.context);

  final addVM = Get.find<AddressViewModel>();

  TextEditingController descController = TextEditingController();
  String? chooseAddress;
  String? chooseNumber;

  Future<void> modalAddAddress() {
    return showModalBottomSheet(
        context: context, builder: (_) => buildManage(null));
  }

  Future<void> modalEditAddress({required AddressModel address}) {
    chooseAddress = addVM.datatypeAddress[address.type!];
    if (chooseAddress == 'คอนโดถนอมมิตร') {
      chooseNumber = address.detail!.split(' ')[1];
    } else {
      descController.text = address.detail!;
    }
    return showModalBottomSheet(
        context: context, builder: (_) => buildManage(address.id!));
  }

  Widget buildManage(String? id) {
    return SizedBox(
      width: 100.w,
      height: 60.h,
      child: StatefulBuilder(
        builder: (_, setState) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Positioned.fill(
                top: 10.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildType(setState),
                      SizedBox(height: 5.h),
                      if (chooseAddress == 'คอนโดถนอมมิตร') ...[
                        buildNumber(setState),
                      ] else if (chooseAddress != 'คอนโดถนอมมิตร' &&
                          chooseAddress != null) ...[
                        buildDesc(),
                      ],
                    ],
                  ),
                ),
              ),
              MyWidget().buildModalHeader(
                  title: id == null ? 'เพิ่มที่อยู่ใหม่' : 'แก้ไขที่อยู่'),
              Positioned(
                bottom: 2.h,
                left: 5.w,
                right: 5.w,
                child: MyWidget().buttonWidget(
                  title:
                      id == null ? 'เพิ่มข้อมูลที่อยู่' : 'แก้ไขข้อมูลที่อยู่',
                  onTap: () {
                    if (chooseAddress == null) {
                      DialogAlert(context).dialogStatus(
                          type: 1, title: 'กรุณาเลือกประเภทที่อยู่');
                    } else if (chooseAddress == 'คอนโดถนอมมิตร' &&
                        chooseNumber == null) {
                      DialogAlert(context)
                          .dialogStatus(type: 1, title: 'กรุณาระบุหมายเลข');
                    } else if (chooseAddress != 'คอนโดถนอมมิตร' &&
                        descController.text.isEmpty) {
                      DialogAlert(context).dialogStatus(
                          type: 1, title: 'กรุณาระบุข้อมูลที่อยู่');
                    } else {
                      id == null
                          ? processInsert(context)
                          : processEdit(context, id);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildType(Function setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('ประเภท : ',
            style: MyStyle.textStyle(size: 16, color: MyStyle.bluePrimary)),
        const SizedBox(width: 10),
        Container(
          width: 60.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.orangeDark),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              iconSize: 30,
              icon: const Icon(Icons.arrow_drop_down_outlined,
                  color: MyStyle.orangePrimary),
              isExpanded: true,
              value: chooseAddress,
              items:
                  addVM.datatypeAddress.map(MyWidget().dropdownItem).toList(),
              onChanged: (value) =>
                  setState(() => chooseAddress = value as String),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNumber(Function setState) {
    descController.clear();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('หมายเลขตึก : ',
            style: MyStyle.textStyle(size: 16, color: MyStyle.bluePrimary)),
        const SizedBox(width: 10),
        Container(
          width: 20.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.orangeDark),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              iconSize: 30,
              icon: const Icon(
                Icons.arrow_drop_down_outlined,
                color: MyStyle.orangePrimary,
              ),
              isExpanded: true,
              value: chooseNumber,
              items:
                  addVM.buildingNumbers.map(MyWidget().dropdownItem).toList(),
              onChanged: (value) {
                setState(() => chooseNumber = value as String);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDesc() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        maxLines: 3,
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: descController,
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.bluePrimary),
          labelText: 'ข้อมูลที่อยู่ :',
          prefixIcon: const Icon(
            Icons.description_rounded,
            color: MyStyle.orangeDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeDark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeLight),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void processInsert(BuildContext context) async {
    bool status = await AddressCRUD().createAddress(
      model: AddressModify(
        userid: MyVariable.userTokenID,
        type: addVM.datatypeAddress.indexOf(chooseAddress!),
        detail: chooseAddress == 'คอนโดถนอมมิตร'
            ? 'อาคาร $chooseNumber'
            : descController.text,
        lat: null,
        lng: null,
        time: MyFunction().getTimeStamp(),
      ),
    );

    if (status) {
      addVM.readAddressList();
      ConsoleLog.toast(text: 'เพิ่มข้อมูล ที่อยู่ เรียบร้อย');
      Get.back();
    } else {
      DialogAlert(context).dialogApi();
    }
  }

  void processEdit(BuildContext context, String id) async {
    bool status = await AddressCRUD().updateAddress(
      id: id,
      model: AddressModify(
        userid: MyVariable.userTokenID,
        type: addVM.datatypeAddress.indexOf(chooseAddress!),
        detail: chooseAddress == 'คอนโดถนอมมิตร'
            ? 'อาคาร $chooseNumber'
            : descController.text,
        lat: null,
        lng: null,
        time: MyFunction().getTimeStamp(),
      ),
    );

    if (status) {
      addVM.readAddressList();
      ConsoleLog.toast(text: 'แก้ไขข้อมูล ที่อยู่ เรียบร้อย');
      Get.back();
    } else {
      DialogAlert(context).dialogApi();
    }
  }
}
