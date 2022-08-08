import 'package:charoz/Component/Address/Modal/add_location.dart';
import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectAddress {
  Future<dynamic> openModalSelectAddress(context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => modalSelectAddress(context));

  Widget modalSelectAddress(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 50.h,
      child: Consumer<AddressProvider>(
        builder: (_, provider, __) => Stack(
          children: [
            if (provider.addressList == null) ...[
              ScreenWidget().showEmptyData(
                  'ยังไม่มีข้อมูลที่อยู่', 'กรุณาเพิ่มข้อมูลที่อยู่')
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
                          itemCount: provider.addressList.length,
                          itemBuilder: (context, index) => buildAddressItem(
                              context, provider.addressList[index], index),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            ScreenWidget().modalTitle('เลือกที่อยู่จัดส่งของคุณ'),
            ScreenWidget().backPage(context),
            Positioned(
              top: -1.h,
              right: 3.w,
              child: IconButton(
                onPressed: () => AddLocation().openModalAddAddress(context),
                icon: Icon(
                  Icons.add_circle_rounded,
                  size: 20.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddressItem(
      BuildContext context, AddressModel address, int index) {
    return InkWell(
      onTap: () {
        Provider.of<AddressProvider>(context, listen: false)
            .selectAddressWhereId(address.id);
        MyFunction().toast('เปลี่ยนที่อยู่จัดส่งเรียบร้อย');
        Navigator.pop(context);
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
                  Text(address.name, style: MyStyle().normalBlue16()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          address.name == 'คอนโดถนอมมิตร'
                              ? 'ตึกหมายเลข ${address.detail}'
                              : address.detail,
                          style: MyStyle().normalBlack14()),
                    ],
                  ),
                ],
              ),
              Icon(Icons.check_circle_rounded,
                  size: 25.sp, color: MyStyle.primary),
            ],
          ),
        ),
      ),
    );
  }
}
