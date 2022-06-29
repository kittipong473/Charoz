import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Model/banner_model.dart';
import 'package:charoz/Model/favourite_model.dart';
import 'package:charoz/Model/maintain_model.dart';
import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Model/notiorder_model.dart';
import 'package:charoz/Model/orderlist_model.dart';
import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Model/time_model.dart';
import 'package:charoz/Model/user_model.dart';

class ConvertModel {
  AddressModel address(dynamic item) {
    return AddressModel(
      addressId: int.parse(item['addressId']),
      addressUserId: int.parse(item['addressUserId']),
      addressName: item['addressName'],
      addressDescription: item['addressDescription'],
      addressLat: double.parse(item['addressLat']),
      addressLng: double.parse(item['addressLng']),
      created: DateTime.parse(item['created']),
      updated: DateTime.parse(item['updated']),
    );
  }

  BannerModel banner(dynamic item) {
    return BannerModel(
      bannerId: int.parse(item['bannerId']),
      bannerName: item['bannerName'],
      bannerUrl: item['bannerUrl'],
      created: DateTime.parse(item['created']),
    );
  }

  FavouriteModel favourite(dynamic item) {
    return FavouriteModel(
      favouriteId: int.parse(item['favouriteId']),
      favouriteUserId: int.parse(item['favouriteUserId']),
      favouriteProducts: item['favouriteProducts'],
      updated: DateTime.parse(item['updated']),
    );
  }

  MaintainModel maintain(dynamic item) {
    return MaintainModel(
      maintainId: int.parse(item['maintainId']),
      maintainName: item['maintainName'],
      maintainDetail: item['maintainDetail'],
      maintainStatus: int.parse(item['maintainStatus']),
    );
  }

  NotiModel noti(dynamic item) {
    return NotiModel(
      notiId: int.parse(item['notiId']),
      notiType: item['notiType'],
      notiName: item['notiName'],
      notiDetail: item['notiDetail'],
      notiImage: item['notiImage'],
      notiStart: DateTime.parse(item['notiStart']),
      notiEnd: DateTime.parse(item['notiEnd']),
      notiStatus: int.parse(item['notiStatus']),
    );
  }

  NotiOrderModel notiorder(dynamic item) {
    return NotiOrderModel(
      notiorderId: int.parse(item['notiorderId']),
      notiorderOrderId: int.parse(item['notiorderOrderId']),
      notiorderName: item['notiorderName'],
      notiorderStatus: item['notiorderStatus'],
      created: DateTime.parse(item['created']),
      updated: DateTime.parse(item['updated']),
    );
  }

  OrderListModel orderlist(dynamic item) {
    return OrderListModel(
      orderId: int.parse(item['orderId']),
      orderShopId: int.parse(item['orderShopId']),
      orderCustomerId: int.parse(item['orderCustomerId']),
      orderRiderId: int.parse(item['orderRiderId']),
      orderProductIds: item['orderProductIds'],
      orderProductAmounts: item['orderProductAmounts'],
      orderTotal: double.parse(item['orderTotal']),
      orderPaymentType: item['orderPaymentType'],
      orderReceiveType: item['orderReceiveType'],
      orderStatus: item['orderStatus'],
      created: DateTime.parse(item['created']),
      updated: DateTime.parse(item['updated']),
    );
  }

  ProductModel product(dynamic item) {
    return ProductModel(
      productId: int.parse(item['productId']),
      productName: item['productName'],
      productType: item['productType'],
      productPrice: double.parse(item['productPrice']),
      productDetail: item['productDetail'],
      productImage: item['productImage'],
      productScore: double.parse(item['productScore']),
      productStatus: int.parse(item['productStatus']),
      productSuggest: int.parse(item['productSuggest']),
      created: DateTime.parse(item['created']),
      updated: DateTime.parse(item['updated']),
    );
  }

  ShopModel shop(dynamic item) {
    return ShopModel(
      shopId: int.parse(item['shopId']),
      shopName: item['shopName'],
      shopAnnounce: item['shopAnnounce'],
      shopDetail: item['shopDetail'],
      shopAddress: item['shopAddress'],
      shopLat: double.parse(item['shopLat']),
      shopLng: double.parse(item['shopLng']),
      shopVideo: item['shopVideo'],
      created: DateTime.parse(item['created']),
      updated: DateTime.parse(item['updated']),
    );
  }

  TimeModel time(dynamic item) {
    return TimeModel(
      timeId: int.parse(item['timeId']),
      shopId: int.parse(item['shopId']),
      timeWeekdayOpen: item['timeWeekdayOpen'],
      timeWeekdayClose: item['timeWeekdayClose'],
      timeWeekendOpen: item['timeWeekendOpen'],
      timeWeekendClose: item['timeWeekendClose'],
      timeStatus: item['timeStatus'],
      timeChoose: item['timeChoose'],
    );
  }

  UserModel user(dynamic item) {
    return UserModel(
      userId: int.parse(item['userId']),
      userFirstName: item['userFirstName'],
      userLastName: item['userLastName'],
      userBirth: DateTime.parse(item['userBirth']),
      userEmail: item['userEmail'],
      userPhone: item['userPhone'],
      userRole: item['userRole'],
      userLocation: int.parse(item['userLocation']),
      userEmailToken: item['userEmailToken'],
      userPhoneToken: item['userPhoneToken'],
      userGoogleToken: item['userGoogleToken'],
    );
  }
}
