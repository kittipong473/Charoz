import 'package:charoz/Service/Api/address_api.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Utilty/Constant/my_dialog.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final formKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  String chooseAddress = '--เลือกสถานที่--';
  String chooseNumber = '0';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Positioned.fill(
                top: 6.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: MyVariable.largeDevice
                        ? const EdgeInsets.symmetric(horizontal: 40)
                        : const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 8.h),
                          buildType(),
                          SizedBox(height: 5.h),
                          if (chooseAddress == 'คอนโดถนอมมิตร') ...[
                            buildNumber(),
                            SizedBox(height: 5.h),
                            buildButton(context, 1),
                          ] else if (chooseAddress != '--เลือกสถานที่--') ...[
                            buildDesc(),
                            SizedBox(height: 5.h),
                            buildButton(context, 2),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('เพิ่มที่อยู่ใหม่'),
              MyWidget().backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Row buildType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ประเภท : ',
          style: MyStyle().boldBlack16(),
        ),
        Container(
          width: 50.w,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.primary),
          ),
          child: DropdownButton(
            iconSize: 36,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: MyStyle.dark,
            ),
            isExpanded: true,
            value: chooseAddress,
            items: MyVariable.locationTypes.map(buildAddressItem).toList(),
            onChanged: (value) {
              setState(() {
                chooseAddress = value as String;
              });
            },
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildAddressItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: MyStyle().normalBlack16(),
      ),
    );
  }

  Row buildNumber() {
    descController.clear();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'หมายเลขตึก : ',
          style: MyStyle().boldBlack16(),
        ),
        Container(
          width: 20.w,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.primary),
          ),
          child: DropdownButton(
            iconSize: 36,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: MyStyle.dark,
            ),
            isExpanded: true,
            value: chooseNumber,
            items: MyVariable.buildingNumbers.map(buildNumberItem).toList(),
            onChanged: (value) {
              setState(() {
                chooseNumber = value as String;
              });
            },
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildNumberItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: MyStyle().normalBlack16(),
      ),
    );
  }

  Row buildDesc() {
    chooseNumber = '0';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 80.w,
          child: TextFormField(
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
        ),
      ],
    );
  }

  Row buildButton(BuildContext context, int check) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 85.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.blue),
            onPressed: () {
              if (check == 1 && chooseNumber == '0') {
                MyDialog().singleDialog(context, 'กรุณาระบุหมายเลขตึก');
              } else if (check == 2 && descController.text.isEmpty) {
                MyDialog().singleDialog(context, 'กรุณาระบุข้อมูลที่อยู่');
              } else {
                processInsert();
              }
            },
            child: Text(
              'เพิ่มข้อมูลที่อยู่',
              style: MyStyle().boldWhite16(),
            ),
          ),
        ),
      ],
    );
  }

  Future processInsert() async {
    String userid = MyVariable.userTokenId;
    String desc = descController.text.isEmpty
        ? 'ตึกหมายเลข $chooseNumber'
        : descController.text;
    String time = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

    bool status = await AddressApi().insertAddress(
      userid: userid,
      name: chooseAddress,
      desc: desc,
      lat: "0",
      lng: "0",
      time: time,
    );

    if (status) {
      MyWidget().toast('เพิ่มข้อมูลที่อยู่เรียบร้อย');
      Navigator.pop(context);
    } else {
      MyDialog().doubleDialog(
          context, 'เพิ่มข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
