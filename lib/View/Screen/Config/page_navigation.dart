import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Model/Utility/my_variable.dart';
import 'package:charoz/View/Dialog/dialog_confirm.dart';
import 'package:charoz/View/Screen/Notification/noti_list.dart';
import 'package:charoz/View/Screen/Order/order_list.dart';
import 'package:charoz/View/Screen/Rider/rider_working.dart';
import 'package:charoz/View/Screen/Shop/shop_detail.dart';
import 'package:charoz/View/Screen/Config/home.dart';
import 'package:charoz/View/Screen/Product/product_list.dart';
import 'package:charoz/View/Screen/User/user_list.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  _PageNavigationState createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation>
    with SingleTickerProviderStateMixin {
  final userVM = Get.find<UserViewModel>();
  List<Widget>? screens;
  List<Tab>? icons;

  @override
  void initState() {
    super.initState();
    MyVariable.tabController = TabController(length: 4, vsync: this);
    getBottomNavigationBar();
  }

  void getBottomNavigationBar() {
    if (userVM.role == 4) {
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
    } else if (userVM.role == 3) {
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
    } else if (userVM.role == 2) {
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
    } else if (userVM.role == 1) {
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
            title: Text('Charoz Steak House',
                style: MyStyle.textStyle(
                    size: 18, color: MyStyle.bluePrimary, bold: true)),
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
              controller: MyVariable.tabController,
              indicatorColor: MyStyle.bluePrimary,
              indicatorWeight: 3,
              tabs: icons!,
            ),
            actions: [
              if (userVM.role == 1) ...[
                buildAction(Icons.store_mall_directory_rounded,
                    RoutePage.routeShopDetail),
              ]
            ],
          ),
          drawer: Drawer(
            child: GetBuilder<UserViewModel>(
              builder: (vm) => Column(
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPicture: Image.asset(MyImage.imgPerson),
                    accountName: Text(
                      'สวัสดี. ${vm.user?.firstname ?? 'ผู้มาเยี่ยมชม'}',
                      style: MyStyle.textStyle(
                          size: 16, color: MyStyle.whitePrimary),
                    ),
                    accountEmail: Text(
                      vm.roleUserList[vm.user?.role ?? 0],
                      style: MyStyle.textStyle(
                          size: 16, color: MyStyle.whitePrimary),
                    ),
                  ),
                  fragmentDrawer(),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: screens!,
            controller: MyVariable.tabController,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }

  Widget fragmentDrawer() {
    return Column(
      children: [
        fragmentDrawerList(
          Icons.difference_rounded,
          'คำถามที่เกี่ยวข้อง',
          'คำถามข้อสงสัยเกี่ยวกับการทำงานของ application',
          () => Get.toNamed(RoutePage.routeQuestionAnswer),
        ),
        if (userVM.role == 0) ...[
          fragmentDrawerList(
            Icons.login_rounded,
            'เข้าสู่ระบบ',
            'เข้าสู่ระบบหรือสมัครสมาชิก ด้วยการยืนยันรหัส OTP ผ่าน SMS',
            () => Get.toNamed(RoutePage.routeLogin),
          ),
        ] else if (userVM.role == 1) ...[
          fragmentDrawerList(
            Icons.account_circle_rounded,
            'โปรไฟล์',
            'ดูโปรไฟล์/แก้ไขข้อมูลผู้ใช้งาน',
            () => Get.toNamed(RoutePage.routeUserProfile),
          ),
          fragmentDrawerList(
            Icons.location_city_rounded,
            'ที่อยู่ของฉัน',
            'เพิ่ม/ลบ/แก้ไขที่อยู่ผู้ใช้งาน',
            () => Get.toNamed(RoutePage.routeLocationList),
          ),
          // fragmentDrawerList(
          //   Icons.connect_without_contact_rounded,
          //   'ติดต่อผู้ดูแล',
          //   'ส่งข้อความ ปัญหา ข้อสงสัย ให้แอดมินทราบ',
          //   () {},
          // ),
        ] else if (userVM.role == 2 || userVM.role == 0) ...[
          fragmentDrawerList(
            Icons.description_rounded,
            'เพิ่มผู้ใช้งาน ไรเดอร์',
            'สร้างบัญชีสำหรับ คนขับ',
            () => Get.toNamed(RoutePage.routeAddRider),
          ),
        ] else if (userVM.role != 0) ...[
          fragmentDrawerList(
            Icons.logout_rounded,
            'ออกจากระบบ',
            'ลงชื่อออกจากระบบ',
            () => DialogConfirm(context).dialogInputConfirm(
              title: 'ยืนยันการ ออกจากระบบ\nหรือไม่',
              submit: () => userVM.setLogoutVariable(),
            ),
          ),
        ],
      ],
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
      title: Text(
        title,
        style:
            MyStyle.textStyle(size: 18, color: MyStyle.bluePrimary, bold: true),
      ),
      subtitle: Text(
        subtitle,
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
      ),
    );
  }

  IconButton buildAction(IconData icon, String route) {
    return IconButton(
      onPressed: () => Get.toNamed(route),
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
            MyWidget()
                .showImage(path: MyImage.lotWarning, width: 15.w, height: 15.w),
            SizedBox(height: 2.h),
            Text(
              "คุณต้องการออกจากระบบหรือไม่ ?",
              style: MyStyle.textStyle(size: 16, color: MyStyle.bluePrimary),
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
                  child: Text(
                    'ยกเลิก',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.redPrimary, bold: true),
                  ),
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
                  child: Text(
                    'ยืนยัน',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.greenPrimary, bold: true),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
