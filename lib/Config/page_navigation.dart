import 'package:charoz/Component/Notification/noti_list.dart';
import 'package:charoz/Component/Order/order_history.dart';
import 'package:charoz/Component/Order/order_list.dart';
import 'package:charoz/Component/Rider/rider_working.dart';
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
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  _PageNavigationState createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  List<Widget>? screens;
  List<Tab>? icons;

  @override
  void initState() {
    super.initState();
    getBottomNavigationBar();
    getData();
  }

  Future getData() async {
    await Provider.of<ShopProvider>(context, listen: false).readShopModel();
    await Provider.of<ShopProvider>(context, listen: false).readTimeModel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DefaultTabController(
        length: 4,
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
              indicatorColor: MyStyle.bluePrimary,
              indicatorWeight: 3,
              tabs: icons!,
            ),
          ),
          drawer: MyVariable.login ? buildDrawerMember() : buildDrawerGuest(),
          body: TabBarView(children: screens!),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              fragmentDrawerList(
                  Icons.edit_road_rounded,
                  'กรอกรหัสสมัครสำหรับคนส่งอาหาร',
                  'สามารถขอรหัสได้ที่ผู้ดูแลร้านค้า',
                  () => Navigator.pushNamed(context, RoutePage.routeRegister)),
            ],
          ),
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
            fragmentDrawerList(
              Icons.logout_rounded,
              'ออกจากระบบ',
              'ลงชื่อออกจากระบบ',
              () => DialogAlert().confirmLogout(context),
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
                () => Navigator.pushNamed(context, RoutePage.routeLocationList),
              ),
            ] else if (MyVariable.role == 'manager' ||
                MyVariable.role == 'role') ...[
              fragmentDrawerList(
                Icons.description_rounded,
                'เพิ่มผู้ใช้งาน ไรเดอร์',
                'สร้าง Serial Number สำหรับไรเดอร์',
                () => Navigator.pushNamed(context, RoutePage.routeAddRider),
              ),
            ],
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
      icon: Icon(
        icon,
        size: 20.sp,
        color: Colors.white,
      ),
    );
  }

  Tab buildTabs(IconData icon) =>
      Tab(icon: Icon(icon, size: 20.sp, color: Colors.white));

  void getBottomNavigationBar() {
    if (MyVariable.role == 'admin') {
      screens = [
        NotiList(notiList: MyVariable.notisAdmin),
        const UserList(),
        const OrderHistory(),
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
        NotiList(notiList: MyVariable.notisManager),
        const ProductList(),
        const OrderHistory(),
        const ShopDetail(),
      ];
      icons = [
        buildTabs(Icons.notifications_active_rounded),
        buildTabs(Icons.restaurant_rounded),
        buildTabs(Icons.receipt_rounded),
        buildTabs(Icons.store_mall_directory_rounded),
      ];
    } else if (MyVariable.role == 'rider') {
      screens = [
        NotiList(notiList: MyVariable.notisRider),
        const RiderWorking(),
        const OrderList(),
        const ShopDetail(),
      ];
      icons = [
        buildTabs(Icons.notifications_active_rounded),
        buildTabs(Icons.delivery_dining_rounded),
        buildTabs(Icons.receipt_rounded),
        buildTabs(Icons.store_mall_directory_rounded),
      ];
    } else if (MyVariable.role == 'customer') {
      screens = [
        const Home(),
        const ProductList(),
        NotiList(notiList: MyVariable.notisCustomer),
        const ShopDetail(),
      ];
      icons = [
        buildTabs(Icons.home_rounded),
        buildTabs(Icons.restaurant_rounded),
        buildTabs(Icons.notifications_active_rounded),
        buildTabs(Icons.store_mall_directory_rounded),
      ];
    } else {
      screens = [
        const Home(),
        const ProductList(),
        NotiList(notiList: MyVariable.notisUser),
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
}
