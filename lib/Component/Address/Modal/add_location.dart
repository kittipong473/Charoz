import 'package:charoz/Model/SubModel/sub_address_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Service/Database/Firebase/address_crud.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Widget/dropdown_menu.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddLocation {
  final formKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  String? chooseAddress;
  String? chooseNumber;

  Future<dynamic> openModalAddAddress(context) =>
      showModalBottomSheet(context: context, builder: (_) => modalAddAddress());

  Widget modalAddAddress() {
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
              ScreenWidget().modalTitle('เพิ่มที่อยู่ใหม่'),
              buildAddButton(context),
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
            items: MyVariable.locationTypes
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
            items: MyVariable.buildingNumbers
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

  Positioned buildAddButton(BuildContext context) {
    return Positioned(
      bottom: 2.h,
      left: 5.w,
      right: 5.w,
      child: SizedBox(
        width: 80.w,
        height: 5.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
          onPressed: () {
            if (chooseAddress == null) {
              DialogAlert().singleDialog(context, 'กรุณาเลือกประเภทที่อยู่');
            } else if (chooseAddress == 'คอนโดถนอมมิตร' &&
                chooseNumber == null) {
              DialogAlert().singleDialog(context, 'กรุณาระบุหมายเลขตึก');
            } else if (chooseAddress != 'คอนโดถนอมมิตร' &&
                descController.text.isEmpty) {
              DialogAlert().singleDialog(context, 'กรุณาระบุข้อมูลที่อยู่');
            } else {
              EasyLoading.show(status: 'loading...');
              processInsert(context);
            }
          },
          child: Text('เพิ่มข้อมูลที่อยู่', style: MyStyle().normalWhite16()),
        ),
      ),
    );
  }

  Future processInsert(BuildContext context) async {
    bool status = await AddressCRUD().createAddress(
      SubAddressModel(
        userid: MyVariable.userTokenId,
        name: chooseAddress!,
        detail:
            descController.text.isEmpty ? chooseNumber! : descController.text,
        lat: 0,
        lng: 0,
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );

    if (status) {
      Provider.of<AddressProvider>(context, listen: false).readAddressList();
      EasyLoading.dismiss();
      MyFunction().toast('เพิ่มข้อมูลที่อยู่เรียบร้อย');
      Navigator.pop(context);
    } else {
      EasyLoading.dismiss();
      DialogAlert().addFailedDialog(context);
    }
  }
}
