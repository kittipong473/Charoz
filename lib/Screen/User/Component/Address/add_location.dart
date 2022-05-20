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
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

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
                          buildName(),
                          SizedBox(height: 5.h),
                          buildDesc(),
                          SizedBox(height: 3.h),
                          buildButton(context),
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

  Row buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ประเภท : ',
          style: MyStyle().boldBlack16(),
        ),
        Container(
          width: 60.w,
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
            value: MyVariable.chooseAddress,
            items: MyVariable.locationTypes.map(buildAddressItem).toList(),
            onChanged: (value) {
              setState(() {
                MyVariable.chooseAddress = value as String;
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

  Row buildDesc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ที่อยู่';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'ที่อยู่ :',
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

  Row buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 85.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.blue),
            onPressed: () {
              if (formKey.currentState!.validate()) {
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
    String userid = await UserApi().getUserIdWhereToken();
    String name = nameController.text;
    String desc = descController.text;
    String time = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

    bool status = await AddressApi().insertAddress(
      userid: userid,
      name: name,
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
