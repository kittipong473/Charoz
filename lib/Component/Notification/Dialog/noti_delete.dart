import 'package:charoz/Provider/noti_provider.dart';
import 'package:charoz/Service/Database/Firebase/noti_crud.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiDelete {
  void confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(MyImage.svgWarning, width: 15.w, height: 15.w),
            SizedBox(height: 2.h),
            Text(
              "คุณต้องการลบ รายการนี้หรือไม่ ?",
              style: MyStyle().normalBlue16(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 25.w,
                height: 4.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red.shade100),
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('ยกเลิก', style: MyStyle().boldRed16()),
                ),
              ),
              SizedBox(
                width: 25.w,
                height: 4.h,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.green.shade100),
                  onPressed: () async {
                    bool status = await NotiCRUD().deleteNoti(id);
                    if (status) {
                      Provider.of<NotiProvider>(context, listen: false)
                          .readNotiTypeList(MyVariable
                              .notiTypeList[MyVariable.indexNotiChip]);
                      MyFunction().toast('ลบรายการเรียบร้อยแล้ว');
                    } else {
                      DialogAlert().deleteFailedDialog(context);
                    }
                    Navigator.pop(dialogContext);
                  },
                  child: Text('ยืนยัน', style: MyStyle().boldGreen16()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
