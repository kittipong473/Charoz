import 'dart:io';

import 'package:charoz/screens/home/component/section/suggestion.dart';
import 'package:charoz/screens/home/model/device_model.dart';
import 'package:charoz/screens/product/component/menu_saler.dart';
import 'package:charoz/screens/shop/component/shop_manage.dart';
import 'package:charoz/screens/home/component/section/home.dart';
import 'package:charoz/screens/product/component/menu_customer.dart';
import 'package:charoz/screens/user/component/login.dart';
import 'package:charoz/screens/user/component/manage_user.dart';
import 'package:charoz/screens/noti/component/noti_customer.dart';
import 'package:charoz/screens/home/model/banner_model.dart';
import 'package:charoz/screens/home/model/maintain_model.dart';
import 'package:charoz/screens/noti/component/noti_saler.dart';
import 'package:charoz/screens/user/component/user_detail.dart';
import 'package:charoz/services/api/home_api.dart';
import 'package:charoz/utils/constant/my_dialog.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
  MaintainModel? _maintain;
  DeviceModel? _device;
  List<Widget> _screens = [];
  List<Widget> _icons = [];
  List<BannerModel> _banners = [];

  get maintain => _maintain;

  get device => _device;

  get screens => _screens;
  get screensLength => _screens.length;

  get icons => _icons;
  get iconsLength => _icons.length;

  get banners => _banners;
  get bannersLength => _banners.length;

  Future initial() async {
    _banners = await HomeApi().getAllBanner();
    return true;
  }

  Future<String> getBottomNavigationBar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String role = preferences.getString('role') ?? '';
    if (role == 'admin') {
      _screens = [
        const NotiCustomer(),
        const ShopManage(),
        const ManageUser(),
        const UserDetail(),
      ];
      _icons = [
        Icon(Icons.campaign_rounded, size: 20.sp),
        Icon(Icons.store_mall_directory_rounded, size: 20.sp),
        Icon(Icons.person_rounded, size: 20.sp),
        Icon(Icons.menu_rounded, size: 20.sp),
      ];
    } else if (role == 'saler') {
      _screens = [
        const NotiSaler(),
        const MenuSaler(),
        const ShopManage(),
        const UserDetail(),
      ];
      _icons = [
        Icon(Icons.receipt_rounded, size: 20.sp),
        Icon(Icons.restaurant_rounded, size: 20.sp),
        Icon(Icons.store_mall_directory_rounded, size: 20.sp),
        Icon(Icons.menu_rounded, size: 20.sp),
      ];
    } else if (role == 'customer') {
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
        const Suggestion(),
        // const Login(),
      ];
      _icons = [
        Icon(Icons.home_rounded, size: 20.sp),
        Icon(Icons.restaurant_rounded, size: 20.sp),
        Icon(Icons.notifications_active_rounded, size: 20.sp),
        Icon(Icons.insert_comment_rounded, size: 20.sp),
        // Icon(Icons.menu_rounded, size: 20.sp),
      ];
    }
    return role;
  }

  Future getMaintenance(String status) async {
    _maintain = await HomeApi().getMaintenance(status: status);
    return _maintain!.maintainStatus;
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

  Future getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String? identify, name, version;
    String date = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    try {
      if (Platform.isAndroid) {
        var android = await deviceInfoPlugin.androidInfo;
        identify = android.androidId;
        name = android.model;
        version = android.version.release.toString();
      } else if (Platform.isIOS) {
        var ios = await deviceInfoPlugin.iosInfo;
        identify = ios.identifierForVendor;
        name = ios.name;
        version = ios.systemVersion;
      }
      _device = await HomeApi().getIdentify(identify: identify!);
      if (_device != null) {
        HomeApi().editCountWhereDevice(
            id: _device!.deviceId,
            count: int.parse(_device!.deviceCount) + 1,
            date: date);
      } else {
        HomeApi().insertDevice(
            identify: identify, name: name!, version: version!, date: date);
      }
      notifyListeners();
    } catch (e) {
      //
    }
  }
}
