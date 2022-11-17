import 'package:charoz/View/Screen/Notification/noti_list.dart';
import 'package:charoz/View/Screen/Order/order_list.dart';
import 'package:charoz/View/Screen/Rider/rider_working.dart';
import 'package:charoz/View/Screen/Shop/shop_detail.dart';
import 'package:charoz/View/Config/home.dart';
import 'package:charoz/View/Screen/Product/product_list.dart';
import 'package:charoz/View/Screen/User/user_list.dart';
import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Util/Constant/my_image.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  _PageNavigationState createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation>
    with SingleTickerProviderStateMixin {
  List<Widget>? screens;
  List<Tab>? icons;

  final ShopViewModel shopVM = Get.find<ShopViewModel>();
  final UserViewModel userVM = Get.find<UserViewModel>();

  @override
  void initState() {
    super.initState();
    VariableGeneral.tabController = TabController(length: 4, vsync: this);
    getBottomNavigationBar();
    getData();
    // getNotification(context);
  }

  void getBottomNavigationBar() {
    if (VariableGeneral.role == 'admin') {
      screens = [
        const NotiList(),
        const UserList(),
        const OrderList(),
        const ShopDetail(),
      ];
      icons = [
        buildTabs(Icons.notifications_active_rounded),
        buildTabs(Icons.account_circle_rounded),
        buildTabs(Icons.receipt_rounded),
        buildTabs(Icons.store_mall_directory_rounded),
      ];
    } else if (VariableGeneral.role == 'manager') {
      screens = [
        const OrderList(),
        const ProductList(),
        const NotiList(),
        const ShopDetail(),
      ];
      icons = [
        buildTabs(Icons.receipt_long_rounded),
        buildTabs(Icons.restaurant_rounded),
        buildTabs(Icons.notifications_active_rounded),
        buildTabs(Icons.store_mall_directory_rounded),
      ];
    } else if (VariableGeneral.role == 'rider') {
      screens = [
        const OrderList(),
        const RiderWorking(),
        const NotiList(),
        const ShopDetail(),
      ];
      icons = [
        buildTabs(Icons.receipt_long_rounded),
        buildTabs(Icons.delivery_dining_rounded),
        buildTabs(Icons.notifications_active_rounded),
        buildTabs(Icons.store_mall_directory_rounded),
      ];
    } else if (VariableGeneral.role == 'customer') {
      screens = [
        const Home(),
        const ProductList(),
        const NotiList(),
        const OrderList(),
      ];
      icons = [
        buildTabs(Icons.home_rounded),
        buildTabs(Icons.restaurant_rounded),
        buildTabs(Icons.notifications_active_rounded),
        buildTabs(Icons.receipt_long_rounded),
      ];
    } else {
      screens = [
        const Home(),
        const ProductList(),
        const NotiList(),
        const ShopDetail(),
      ];
      icons = [
        buildTabs(Icons.home_rounded),
        buildTabs(Icons.restaurant_rounded),
        buildTabs(Icons.notifications_active_rounded),
        buildTabs(Icons.store_mall_directory_rounded),
      ];
    }
  }

  void getData() async {
    await shopVM.readShopModel();
  }

  void getNotification(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      String? title = event.notification!.title;
      showSimpleNotification(
        Text(title!, style: MyStyle().normalWhite16()),
        background: MyStyle.bluePrimary,
        autoDismiss: true,
        trailing: TextButton(
          onPressed: () {
            OverlaySupportEntry.of(context)!.dismiss();
          },
          child: Text('Dismiss', style: MyStyle().boldRed16()),
        ),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      String? title = event.notification!.title;
      showSimpleNotification(
        Text(title!, style: MyStyle().normalWhite16()),
        background: MyStyle.light,
        autoDismiss: true,
        trailing: TextButton(
          onPressed: () {
            OverlaySupportEntry.of(context)!.dismiss();
          },
          child: Text('Dismiss', style: MyStyle().boldRed16()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DefaultTabController(
        length: screens!.length,
        child: Scaffold(
          backgroundColor: MyStyle.colorBackGround,
          appBar: AppBar(
            title: Text(VariableData.mainTitle, style: MyStyle().boldBlue18()),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            toolbarHeight: 5.h,
            elevation: 10,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade200, Colors.orange.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            bottom: TabBar(
              controller: VariableGeneral.tabController,
              indicatorColor: MyStyle.bluePrimary,
              indicatorWeight: 3,
              tabs: icons!,
            ),
            actions: [
              if (VariableGeneral.role == 'customer') ...[
                buildAction(Icons.store_mall_directory_rounded,
                    RoutePage.routeShopDetail),
              ],
            ],
          ),
          drawer: VariableGeneral.isLogin!
              ? buildDrawerMember()
              : buildDrawerGuest(),
          body: TabBarView(
            children: screens!,
            controller: VariableGeneral.tabController,
          ),
        ),
      ),
    );
  }

  Drawer buildDrawerGuest() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: Image.asset(MyImage.person),
            accountName: Text('สวัสดี!', style: MyStyle().normalWhite16()),
            accountEmail:
                Text('ผู้มาเยี่ยมชม', style: MyStyle().normalWhite16()),
          ),
          fragmentDrawerList(
              Icons.login_rounded,
              'เข้าสู่ระบบ หรือ สมัครสมาชิก',
              'ด้วยการยืนยันรหัส OTP ผ่าน SMS',
              () => Navigator.pushNamed(context, RoutePage.routeLogin)),
          fragmentDrawerList(
              Icons.difference_rounded,
              'คำถามที่เกี่ยวข้อง',
              'คำถามข้อสงสัยการทำงานของ application',
              () => Navigator.pushNamed(context, RoutePage.routeRegister)),
          fragmentDrawerList(
              Icons.privacy_tip_rounded,
              'ข้อกำหนดการเป็นสมาชิก',
              'เงื่อนไขการให้บริการ และ นโยบายความเป็นส่วนตัว',
              () => Navigator.pushNamed(context, RoutePage.routePrivacyPolicy)),
        ],
      ),
    );
  }

  Drawer buildDrawerMember() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: Image.asset(MyImage.person),
            accountName: Text('สวัสดี. ${userVM.user.firstname ?? ''}',
                style: MyStyle().normalWhite16()),
            accountEmail:
                Text(userVM.user.role ?? '', style: MyStyle().normalWhite16()),
          ),
          if (VariableGeneral.role == 'customer') ...[
            // fragmentDrawerList(
            //   Icons.edit_rounded,
            //   'แก้ไขข้อมูล',
            //   'เพิ่มรูป/แก้ไขชื่อนามสกุลผู้ใช้งาน',
            //   () => EditUser().openModalEditUser(context, provider.user),
            // ),
            fragmentDrawerList(
              Icons.location_city_rounded,
              'ที่อยู่ของฉัน',
              'เพิ่ม/ลบ/แก้ไขที่อยู่ผู้ใช้งาน',
              () => Navigator.pushNamed(context, RoutePage.routeLocationList),
            ),
            // fragmentDrawerList(
            //   Icons.connect_without_contact_rounded,
            //   'ติดต่อผู้ดูแล',
            //   'ส่งข้อความ ปัญหา ข้อสงสัย ให้แอดมินทราบ',
            //   () {},
            // ),
          ] else if (VariableGeneral.role == 'manager' ||
              VariableGeneral.role == 'role') ...[
            fragmentDrawerList(
              Icons.description_rounded,
              'เพิ่มผู้ใช้งาน ไรเดอร์',
              'สร้างบัญชีสำหรับ คนขับ',
              () => Navigator.pushNamed(context, RoutePage.routeAddRider),
            ),
          ],
          fragmentDrawerList(
            Icons.logout_rounded,
            'ออกจากระบบ',
            'ลงชื่อออกจากระบบ',
            () => confirmLogout(context),
          ),
        ],
      ),
    );
  }

  Widget fragmentDrawerList(
      IconData icon, String title, String subtitle, Function function) {
    return ListTile(
      onTap: () => function(),
      contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      leading: Icon(
        icon,
        size: 25.sp,
        color: MyStyle.primary,
      ),
      title: Text(title, style: MyStyle().boldBlue18()),
      subtitle: Text(subtitle, style: MyStyle().normalBlack16()),
    );
  }

  IconButton buildAction(IconData icon, String route) {
    return IconButton(
      onPressed: () => Navigator.pushNamed(context, route),
      icon: Icon(icon, size: 20.sp, color: Colors.white),
    );
  }

  Tab buildTabs(IconData icon) =>
      Tab(icon: Icon(icon, size: 20.sp, color: Colors.white));

  void confirmLogout(BuildContext context) {
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
              "คุณต้องการออกจากระบบหรือไม่ ?",
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100),
                  onPressed: () => Get.back(),
                  child: Text('ยกเลิก', style: MyStyle().boldRed16()),
                ),
              ),
              SizedBox(
                width: 25.w,
                height: 4.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100),
                  onPressed: () {
                    Get.back();
                    userVM.signOutFirebase(context);
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
