import 'package:charoz/Model/Data/address_model.dart';
import 'package:charoz/Model/Api/Request/address_modify.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/address_crud.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Widget/dropdown_menu.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditLocation {
  final formKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();
  String? chooseAddress;
  String? chooseNumber;

  final AddressViewModel addVM = Get.find<AddressViewModel>();

  Future<dynamic> openModalEditAddress(context, AddressModel address) {
    chooseAddress = address.type.toString();
    if (chooseAddress == 'คอนโดถนอมมิตร') {
      chooseNumber = address.detail;
    } else {
      descController.text = address.detail;
    }
    return showModalBottomSheet(
        context: context, builder: (_) => modalEditAddress(address.id));
  }

  Widget modalEditAddress(String id) {
    return SizedBox(
      width: 100.w,
      height: 50.h,
      child: StatefulBuilder(
        builder: (context, setState) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Positioned.fill(
                top: 8.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildType(setState),
                          SizedBox(height: 3.h),
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
                ),
              ),
              ScreenWidget().modalTitle('แก้ไขที่อยู่'),
              buildEditButton(context, id),
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
        Text('ประเภท : ', style: MyStyle().normalBlack16()),
        Container(
          width: 40.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.dark),
          ),
          child: DropdownButton(
            iconSize: 24.sp,
            icon: const Icon(Icons.arrow_drop_down_outlined,
                color: MyStyle.primary),
            isExpanded: true,
            value: chooseAddress,
            items: VariableData.locationTypes
                .map(DropDownMenu().dropdownItem)
                .toList(),
            onChanged: (value) =>
                setState(() => chooseAddress = value as String),
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
        Text('หมายเลขตึก : ', style: MyStyle().normalBlack16()),
        Container(
          width: 20.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.dark),
          ),
          child: DropdownButton(
            iconSize: 24.sp,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: MyStyle.primary,
            ),
            isExpanded: true,
            value: chooseNumber,
            items: VariableData.buildingNumbers
                .map(DropDownMenu().dropdownItem)
                .toList(),
            onChanged: (value) {
              setState(() => chooseNumber = value as String);
            },
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
        style: MyStyle().normalBlack16(),
        controller: descController,
        decoration: InputDecoration(
          labelStyle: MyStyle().boldBlack16(),
          labelText: 'ข้อมูลที่อยู่ :',
          prefixIcon: const Icon(
            Icons.description_rounded,
            color: MyStyle.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.light),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Positioned buildEditButton(BuildContext context, String id) {
    return Positioned(
      bottom: 2.h,
      left: 5.w,
      right: 5.w,
      child: SizedBox(
        width: 80.w,
        height: 5.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
          onPressed: () {
            if (chooseAddress == null) {
              MyDialog(context).singleDialog('กรุณาเลือกประเภทที่อยู่');
            } else if (chooseAddress == 'คอนโดถนอมมิตร' &&
                chooseNumber == null) {
              MyDialog(context).singleDialog('กรุณาระบุหมายเลขตึก');
            } else if (chooseAddress != 'คอนโดถนอมมิตร' &&
                descController.text.isEmpty) {
              MyDialog(context).singleDialog('กรุณาระบุข้อมูลที่อยู่');
            } else {
              EasyLoading.show(status: 'loading...');
              processEdit(context, id);
            }
          },
          child: Text('เพิ่มข้อมูลที่อยู่', style: MyStyle().normalWhite16()),
        ),
      ),
    );
  }

  Future processEdit(BuildContext context, String id) async {
    bool status = await AddressCRUD().updateAddress(
      id,
      AddressManage(
        userid: VariableGeneral.userTokenId!,
        type: VariableData.locationTypes.indexOf(chooseAddress!),
        detail: descController.text,
        lat: 0,
        lng: 0,
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );

    if (status) {
      addVM.readAddressList();
      EasyLoading.dismiss();
      MyFunction().toast('เพิ่มข้อมูลที่อยู่เรียบร้อย');
      Navigator.pop(context);
    } else {
      EasyLoading.dismiss();
      MyDialog(context).editFailedDialog();
    }
  }
}
