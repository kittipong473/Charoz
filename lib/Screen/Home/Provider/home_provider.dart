import 'package:charoz/Screen/Home/Component/home.dart';
import 'package:charoz/Screen/Home/Model/banner_model.dart';
import 'package:charoz/Screen/Home/Model/maintenance_model.dart';
import 'package:charoz/Screen/Notification/Component/noti_customer.dart';
import 'package:charoz/Screen/Notification/Component/noti_saler.dart';
import 'package:charoz/Screen/Product/Component/menu_customer.dart';
import 'package:charoz/Screen/Product/Component/menu_saler.dart';
import 'package:charoz/Screen/Shop/Component/shop_list.dart';
import 'package:charoz/Screen/Suggestion/Component/suggest_question.dart';
import 'package:charoz/Screen/User/Component/user_detail.dart';
import 'package:charoz/Screen/User/Component/user_list.dart';
import 'package:charoz/Service/Api/home_api.dart';
import 'package:charoz/Utilty/Constant/my_dialog.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeProvider with ChangeNotifier {
  MaintenanceModel? _maintain;
  List<Widget> _screens = [];
  List<Widget> _icons = [];
  List<BannerModel> _banners = [];

  get maintain => _maintain;

  get screens => _screens;
  get screensLength => _screens.length;

  get icons => _icons;
  get iconsLength => _icons.length;

  get banners => _banners;
  get bannersLength => _banners.length;

  void getBottomNavigationBar() {
    if (MyVariable.role == 'admin') {
      _screens = [
        const NotiCustomer(),
        const ShopList(),
        const UserList(),
        const UserDetail(),
      ];
      _icons = [
        Icon(Icons.campaign_rounded, size: 20.sp),
        Icon(Icons.store_mall_directory_rounded, size: 20.sp),
        Icon(Icons.person_rounded, size: 20.sp),
        Icon(Icons.menu_rounded, size: 20.sp),
      ];
    } else if (MyVariable.role == 'manager') {
      _screens = [
        const NotiSaler(),
        const MenuSaler(),
        const ShopList(),
        const UserDetail(),
      ];
      _icons = [
        Icon(Icons.receipt_rounded, size: 20.sp),
        Icon(Icons.restaurant_rounded, size: 20.sp),
        Icon(Icons.store_mall_directory_rounded, size: 20.sp),
        Icon(Icons.menu_rounded, size: 20.sp),
      ];
    } else if (MyVariable.role == 'customer') {
      _screens = [
        const Home(),
        const MenuCustomer(),
        const NotiCustomer(),
        const UserDetail(),
      ];
      _icons = [
        Icon(Icons.home_rounded, size: 20.sp),
        Icon(Icons.restaurant_rounded, size: 20.sp),
        Icon(Icons.notifications_active_rounded, size: 20.sp),
        Icon(Icons.menu_rounded, size: 20.sp),
      ];
    } else {
      _screens = [
        const Home(),
        const MenuCustomer(),
        const NotiCustomer(),
        const SuggestQuestion(),
      ];
      _icons = [
        Icon(Icons.home_rounded, size: 20.sp),
        Icon(Icons.restaurant_rounded, size: 20.sp),
        Icon(Icons.notifications_active_rounded, size: 20.sp),
        Icon(Icons.comment_rounded, size: 20.sp),
        // Icon(Icons.menu_rounded, size: 20.sp),
      ];
    }
  }

  Future getAllBanner() async {
    _banners = await HomeApi().getAllBanner();
    notifyListeners();
  }

  Future getMaintenance(String status) async {
    _maintain = await HomeApi().getMaintenance(status: status);
    notifyListeners();
  }

  Future checkPermission(BuildContext context) async {
    bool locationService;
    LocationPermission locationPermission;
    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(context, 'ไม่สามารถใช้งานได้',
              'กรุณาอนุญาตการเข้าถึง Location เพื่อเข้าใช้งานแอพพลิเคชั่น');
        } else {
          return true;
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(context, 'ไม่สามารถใช้งานได้',
              'กรุณาอนุญาตการเข้าถึง Location เพื่อเข้าใช้งานแอพพลิเคชั่น');
        } else {
          return true;
        }
      }
    } else {
      MyDialog().alertLocationService(context, 'Location ของคุณปิดอยู่',
          'กรูณาเปิด Location เพื่อเข้าใช้งานแอพพลิเคชั่น');
      return false;
    }
  }

  // Future getDeviceInfo() async {
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   String? identify, name, version;
  //   String date = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
  //   try {
  //     if (Platform.isAndroid) {
  //       var android = await deviceInfoPlugin.androidInfo;
  //       identify = android.androidId;
  //       name = android.model;
  //       version = android.version.release.toString();
  //     } else if (Platform.isIOS) {
  //       var ios = await deviceInfoPlugin.iosInfo;
  //       identify = ios.identifierForVendor;
  //       name = ios.name;
  //       version = ios.systemVersion;
  //     }
  //     _device = await HomeApi().getIdentify(identify: identify!);
  //     if (_device != null) {
  //       HomeApi().editCountWhereDevice(
  //           id: _device!.deviceId,
  //           count: int.parse(_device!.deviceCount) + 1,
  //           date: date);
  //     } else {
  //       HomeApi().insertDevice(
  //           identify: identify, name: name!, version: version!, date: date);
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     //
  //   }
  // }
}
