import 'package:charoz/Component/Notification/noti_list.dart';
import 'package:charoz/Component/Order/order_list.dart';
import 'package:charoz/Component/Rider/rider_working.dart';
import 'package:charoz/Component/Security/Dialog/security_dialog.dart';
import 'package:charoz/Component/Shop/shop_detail.dart';
import 'package:charoz/Component/User/Modal/edit_user.dart';
import 'package:charoz/Config/home.dart';
import 'package:charoz/Component/Product/product_list.dart';
import 'package:charoz/Component/User/user_list.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  _PageNavigationState createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation>
    with SingleTickerProviderStateMixin {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  List<Widget>? screens;
  List<Tab>? icons;

  @override
  void initState() {
    super.initState();
    MyVariable.tabController = TabController(length: 4, vsync: this);
    getBottomNavigationBar();
    getData();
  }

  void getBottomNavigationBar() {
    if (MyVariable.role == 'admin') {
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
    } else if (MyVariable.role == 'manager') {
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
    } else if (MyVariable.role == 'rider') {
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
    } else if (MyVariable.role == 'customer') {
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

  Future getData() async {
    await Provider.of<ShopProvider>(context, listen: false).readShopModel();
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
            title: Text(MyVariable.mainTitle, style: MyStyle().boldBlue18()),
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
              if (MyVariable.role == 'customer') ...[
                buildAction(Icons.store_mall_directory_rounded,
                    RoutePage.routeShopDetail),
              ],
            ],
          ),
          drawer: MyVariable.login ? buildDrawerMember() : buildDrawerGuest(),
          body: TabBarView(
            children: screens!,
            controller: MyVariable.tabController,
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
            accountName:
                Text('ผู้มาเยี่ยมชม', style: MyStyle().normalWhite16()),
            accountEmail: Text('Guest', style: MyStyle().normalWhite16()),
          ),
          fragmentDrawerList(
              Icons.login_rounded,
              'เข้าสู่ระบบ',
              'เพื่อสั่งอาหารกับทางร้าน',
              () => Navigator.pushNamed(context, RoutePage.routeLogin)),
          fragmentDrawerList(
              Icons.app_registration_rounded,
              'สมัครสมาชิก',
              'สำหรับคนที่ยังไม่ได้เป็นสมาชิก',
              () => Navigator.pushNamed(context, RoutePage.routeRegister)),
        ],
      ),
    );
  }

  Drawer buildDrawerMember() {
    return Drawer(
      child: Consumer<UserProvider>(
        builder: (_, provider, __) => Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Image.asset(MyImage.person),
              accountName: Text('สวัสดี. ${provider.user.firstname}',
                  style: MyStyle().normalWhite16()),
              accountEmail:
                  Text(provider.user.role, style: MyStyle().normalWhite16()),
            ),
            if (MyVariable.role == 'customer') ...[
              fragmentDrawerList(
                Icons.edit_rounded,
                'แก้ไขข้อมูล',
                'เพิ่มรูป/แก้ไขชื่อนามสกุลผู้ใช้งาน',
                () => EditUser().openModalEditUser(context, provider.user),
              ),
              fragmentDrawerList(
                Icons.location_city_rounded,
                'ที่อยู่ของฉัน',
                'เพิ่ม/ลบ/แก้ไขที่อยู่ผู้ใช้งาน',
                () => Navigator.pushNamed(context, RoutePage.routeLocationList),
              ),
              fragmentDrawerList(
                Icons.connect_without_contact_rounded,
                'ติดต่อผู้ดูแล',
                'ส่งข้อความ ปัญหา ข้อสงสัย ให้แอดมินทราบ',
                () {},
              ),
            ] else if (MyVariable.role == 'manager' ||
                MyVariable.role == 'role') ...[
              fragmentDrawerList(
                Icons.description_rounded,
                'เพิ่มผู้ใช้งาน ไรเดอร์',
                'สร้างบัญชีสำหรับ คนขับ',
                () => Navigator.pushNamed(context, RoutePage.routeAddRider),
              ),
            ],
            fragmentDrawerList(
              Icons.pin,
              'จัดการ รหัส pin',
              'เพิ่ม/แก้ไข/ลบ รหัส pincode ของผู้ใช้งาน',
              () => provider.user.pincode == ""
                  ? SecurityDialog().setPinCode(context)
                  : Navigator.pushNamed(context, RoutePage.routeCodeManage),
            ),
            fragmentDrawerList(
              Icons.logout_rounded,
              'ออกจากระบบ',
              'ลงชื่อออกจากระบบ',
              () => confirmLogout(context),
            ),
          ],
        ),
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
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    EasyLoading.show(status: 'loading...');
                    Provider.of<UserProvider>(context, listen: false)
                        .signOutFirebase(context);
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
