import 'package:charoz/Screen/Home/Model/banner_model.dart';
import 'package:charoz/Screen/Home/Model/maintenance_model.dart';
import 'package:charoz/Service/Api/home_api.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:flutter/material.dart';

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
      _screens = MyVariable.adminScreens;
      _icons = MyVariable.adminIcons;
    } else if (MyVariable.role == 'manager') {
      _screens = MyVariable.managerScreens;
      _icons = MyVariable.managerIcons;
    } else if (MyVariable.role == 'customer') {
      _screens = MyVariable.customerScreens;
      _icons = MyVariable.customerIcons;
    } else {
      _screens = MyVariable.startScreens;
      _icons = MyVariable.startIcons;
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

//       types = sprovider.shop!.shopVideo.split(".");
//     if (types[1] == 'mp3' || types[1] == 'mp4') {
//       setVideo(sprovider.shop!.shopVideo);
//     }
}
