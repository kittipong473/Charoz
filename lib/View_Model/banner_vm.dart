import 'package:charoz/Model/Api/FireStore/banner_model.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Service/Firebase/banner_crud.dart';
import 'package:get/get.dart';

class BannerViewModel extends GetxController {
  List<String> datatypeBanner = ['profile', 'carousel', 'icon', 'video'];

  BannerModel? _shopProfile;
  final RxList<BannerModel> _bannerList = <BannerModel>[].obs;
  final RxList<String> _shopImageList = <String>[].obs;

  BannerModel? get shopProfile => _shopProfile;
  List<BannerModel> get bannerList => _bannerList;
  List<String> get shopImageList => _shopImageList;

  void initCarouselList() {
    _shopImageList.value = [
      MyImage.imgShop2,
      MyImage.imgShop3,
      MyImage.imgShop4
    ];
  }

  void readShopProfile() async {
    if (_shopProfile == null) {
      _shopProfile = await BannerCRUD().readBannerByType(type: 0);
      update();
    }
  }

  void readBannerList() async {
    if (_bannerList.isEmpty) {
      _bannerList.value = await BannerCRUD().readCarouselList();
      update();
    }
  }
}
