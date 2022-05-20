import 'package:charoz/Screen/User/Model/address_model.dart';
import 'package:charoz/Screen/User/Provider/address_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
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
          builder: (context, aprovider, child) => aprovider.addresses.isEmpty ||
                  aprovider.address == null
              ? const ShowProgress()
              : Stack(
                  children: [
                    Positioned.fill(
                      top: 7.h,
                      child: Column(
                        children: [
                          buildCurrentLocation(aprovider.address),
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
              Navigator.pushNamed(context, RoutePage.routeAddLocation),
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

  Widget buildAddressItem(AddressModel address, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RoutePage.routeShopDetail);
        },
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
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      address.addressDescription,
                      style: MyStyle().normalBlack14(),
                    ),
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
}
