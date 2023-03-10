import 'package:charoz/View/Screen/Notification/noti_list.dart';
import 'package:charoz/View/Screen/Order/order_list.dart';
import 'package:charoz/View/Screen/Rider/rider_working.dart';
import 'package:charoz/View/Screen/Shop/shop_detail.dart';
import 'package:charoz/View/Config/home.dart';
import 'package:charoz/View/Screen/Product/product_list.dart';
import 'package:charoz/View/Screen/User/user_list.dart';
import 'package:charoz/Service/Initial/route_page.dart';
import 'package:charoz/Model/Util/Constant/my_image.dart';
import 'package:charoz/Model/Util/Constant/my_style.dart';
import 'package:charoz/Model/Util/Variable/var_data.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/time_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    VariableGeneral.tabController = TabController(length: 4, vsync: this);
    getBottomNavigationBar();
  }

  void getBottomNavigationBar() {
    if (VariableGeneral.role == 0) {
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
    } else if (VariableGeneral.role == 3) {
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
    } else if (VariableGeneral.role == 2) {
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
    } else if (VariableGeneral.role == 1) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DefaultTabController(
        length: screens!.length,
        child: Scaffold(
          backgroundColor: MyStyle.backgroundColor,
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
              if (VariableGeneral.role == 1) ...[
                buildAction(Icons.store_mall_directory_rounded,
                    RoutePage.routeShopDetail),
              ],
            ],
          ),
          drawer: Drawer(
            child: GetBuilder<UserViewModel>(
              builder: (vm) => Column(
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPicture: Image.asset(MyImage.person),
                    accountName: Text(
                        'สวัสดี. ${vm.user?.firstname ?? 'ผู้มาเยี่ยมชม'}',
                        style: MyStyle().normalWhite16()),
                    accountEmail: Text(vm.roleUserList[vm.user?.role ?? 4],
                        style: MyStyle().normalWhite16()),
                  ),
                  if (VariableGeneral.role == null) ...[
                    fragmentDrawerGuest(),
                  ],
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: screens!,
            controller: VariableGeneral.tabController,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }

  Widget fragmentDrawerGuest() {
    return Column(
      children: [
        fragmentDrawerList(
            Icons.login_rounded,
            'เข้าสู่ระบบ หรือ สมัครสมาชิก',
            'ด้วยการยืนยันรหัส OTP ผ่าน SMS',
            () => Navigator.pushNamed(context, RoutePage.routeLogin)),
        fragmentDrawerList(Icons.difference_rounded, 'คำถามที่เกี่ยวข้อง',
            'คำถามข้อสงสัยการทำงานของ application', () {}),
        fragmentDrawerList(
            Icons.privacy_tip_rounded,
            'ข้อกำหนดการเป็นสมาชิก',
            'เงื่อนไขการให้บริการ และ นโยบายความเป็นส่วนตัว',
            () => Navigator.pushNamed(context, RoutePage.routePrivacyPolicy)),
      ],
    );
  }

  Drawer buildDrawerMember() {
    return Drawer(
      child: Column(
        children: [
          if (VariableGeneral.role == 1) ...[
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
          ] else if (VariableGeneral.role == 2 ||
              VariableGeneral.role == 0) ...[
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
        color: MyStyle.orangePrimary,
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
                    // userVM.signOutFirebase(context);
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
