// import 'package:charoz/Provider/user_provider.dart';
// import 'package:charoz/Model/Service/CRUD/Firebase/user_crud.dart';
// import 'package:charoz/Model/Service/Route/route_page.dart';
// import 'package:charoz/Util/Constant/my_style.dart';
// import 'package:charoz/View/Function/dialog_alert.dart';
// import 'package:charoz/View/Function/my_function.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class SecurityDialog {
//   void managePinCode(BuildContext context, String id) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => SimpleDialog(
//         contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.info_rounded,
//               size: 15.w,
//               color: MyStyle.bluePrimary,
//             ),
//             SizedBox(height: 2.h),
//             Text(
//               "ตั้งค่า รหัส Pin ของคุณอย่างไร ?",
//               style: MyStyle().normalBlue16(),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               SizedBox(
//                 width: 25.w,
//                 height: 4.h,
//                 child: ElevatedButton(
//                   style:
//                       ElevatedButton.styleFrom(primary: Colors.orange.shade100),
//                   onPressed: () {
//                     Navigator.pop(dialogContext);
//                     Navigator.pop(context);
//                     Navigator.pushNamed(context, RoutePage.routeCodeSetting);
//                   },
//                   child: Text('แก้ไขรหัส', style: MyStyle().boldPrimary16()),
//                 ),
//               ),
//               SizedBox(
//                 width: 25.w,
//                 height: 4.h,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(primary: Colors.red.shade100),
//                   onPressed: () async {
//                     bool status = await UserCRUD().updateUserCode(id, "");
//                     if (status) {
//                       Provider.of<UserProvider>(context, listen: false)
//                           .readUserById(id);
//                       Navigator.pop(dialogContext);
//                       Navigator.pop(context);
//                       MyFunction().toast('ลบรหัส Pin เรียบร้อย');
//                     } else {
//                       MyDialog(context).doubleDialog(
//                         'ลบรหัส pin ล้มเหลว',
//                         'กรุณาลองใหม่อีกครั้งในภายหลัง',
//                       );
//                     }
//                   },
//                   child: Text('ลบรหัส', style: MyStyle().boldRed16()),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void setPinCode(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => SimpleDialog(
//         contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.info_rounded,
//               size: 15.w,
//               color: MyStyle.bluePrimary,
//             ),
//             SizedBox(height: 2.h),
//             Text(
//               "คุณต้องการตั้งรหัส Pin หรือไม่ ?",
//               style: MyStyle().normalBlue16(),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//         children: [
//           SizedBox(
//             width: 25.w,
//             height: 4.h,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(primary: Colors.orange.shade100),
//               onPressed: () {
//                 Navigator.pop(dialogContext);
//                 Navigator.pushNamed(context, RoutePage.routeCodeSetting);
//               },
//               child: Text('ตั้งรหัส Pin', style: MyStyle().boldPrimary16()),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
