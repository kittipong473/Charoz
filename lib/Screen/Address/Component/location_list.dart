import 'package:animations/animations.dart';
import 'package:charoz/Screen/Address/Component/edit_location.dart';
import 'package:charoz/Screen/Address/Model/address_model.dart';
import 'package:charoz/Screen/Address/Provider/address_provider.dart';
import 'package:charoz/Service/Api/address_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Provider.of<AddressProvider>(context, listen: false).getAllAddress();
    Provider.of<AddressProvider>(context, listen: false)
        .getCurrentAddressWhereId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<AddressProvider>(
          builder: (context, aprovider, child) => Stack(
            children: [
              if (aprovider.addresses.isEmpty) ...[
                MyWidget().emptyData(
                    'ยังไม่มีข้อมูลที่อยู่', 'กรุณาเพิ่มข้อมูลที่อยู่')
              ] else ...[
                Positioned.fill(
                  top: 7.h,
                  child: Column(
                    children: [
                      if (aprovider.address == null) ...[
                        buildCurrentEmpty(),
                      ] else ...[
                        buildCurrentLocation(aprovider.address),
                      ],
                      Container(
                        width: 100.w,
                        height: 75.h,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 0),
                          shrinkWrap: true,
                          itemCount: aprovider.addressesLength,
                          itemBuilder: (context, index) => buildAddressItem(
                              aprovider.addresses[index], index),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              MyWidget().backgroundTitle(),
              MyWidget().title('รายการที่อยู่ของคุณ'),
              MyWidget().backPage(context),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyStyle.primary,
          child: const Icon(Icons.add_rounded),
          onPressed: () =>
              Navigator.pushNamed(context, RoutePage.routeAddLocation)
                  .then((value) => getData()),
        ),
      ),
    );
  }

  Widget buildCurrentLocation(AddressModel address) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          Icons.location_city_rounded,
          size: 25.sp,
          color: MyStyle.blue,
        ),
        title: Text(
          'ที่อยู่ปัจจุบัน : ${address.addressName}',
          style: MyStyle().boldBlack16(),
        ),
        subtitle: Text(
          address.addressDescription,
          style: MyStyle().normalBlack14(),
        ),
      ),
    );
  }

  Widget buildCurrentEmpty() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          Icons.location_city_rounded,
          size: 25.sp,
          color: MyStyle.blue,
        ),
        title: Text(
          'ที่อยู่ปัจจุบัน : ยังไม่ได้เลือก',
          style: MyStyle().boldBlack16(),
        ),
        subtitle: Text(
          'กรุณาเลือกที่อยู่ปัจจุบัน',
          style: MyStyle().normalBlack14(),
        ),
      ),
    );
  }

  Widget buildAddressItem(AddressModel address, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5.0,
      child: InkWell(
        onTap: () => dialogManageAddress(address),
        child: Padding(
          padding: MyVariable.largeDevice
              ? const EdgeInsets.all(20)
              : const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.pin_drop_rounded,
                color: MyStyle.blue,
                size: 25.sp,
              ),
              Column(
                children: [
                  Text(
                    address.addressName,
                    style: MyStyle().boldBlue16(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        address.addressDescription,
                        style: MyStyle().normalBlack14(),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.edit_rounded,
                size: 20.sp,
                color: MyStyle.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogManageAddress(AddressModel address) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'จัดการที่อยู่ ${address.addressName}',
                style: MyStyle().boldBlue18(),
              ),
            ],
          ),
          children: [
            SizedBox(
              width: 40.w,
              height: 5.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: MyStyle.primary),
                onPressed: () {
                  AddressApi()
                      .deleteAddressWhereId(id: address.addressId)
                      .then((value) {
                    MyWidget().toast('ลบที่อยู่ ${address.addressName}');
                    Navigator.pop(context);
                    getData();
                  });
                },
                child: Text(
                  'ใช้เป็นที่อยู่ปัจจุบัน',
                  style: MyStyle().boldWhite16(),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: 40.w,
              height: 5.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditLocation(address: address))),
                child: Text(
                  'แก้ไขที่อยู่',
                  style: MyStyle().boldWhite16(),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: 40.w,
              height: 5.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  AddressApi()
                      .deleteAddressWhereId(id: address.addressId)
                      .then((value) {
                    MyWidget().toast('ลบที่อยู่ ${address.addressName}');
                    Navigator.pop(context);
                    getData();
                  });
                },
                child: Text(
                  'ลบที่อยู่',
                  style: MyStyle().boldWhite16(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
