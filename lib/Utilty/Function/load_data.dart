import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadData {
  Future getDataByRole(BuildContext context) async {
    if (GlobalVariable.role == 'admin') {
      await Provider.of<UserProvider>(context, listen: false)
          .getUserWhereId(GlobalVariable.userTokenId);
      await Provider.of<UserProvider>(context, listen: false).getAllUser();
    } else if (GlobalVariable.role == 'manager') {
      await Provider.of<UserProvider>(context, listen: false)
          .getUserWhereId(GlobalVariable.userTokenId);
      await Provider.of<ProductProvider>(context, listen: false)
          .getAllProduct();
      await Provider.of<OrderProvider>(context, listen: false)
          .getAllOrderWhereManager();
      await Provider.of<OrderProvider>(context, listen: false)
          .getAllOrderWhereManagerDone();
    } else if (GlobalVariable.role == 'rider') {
      await Provider.of<UserProvider>(context, listen: false)
          .getUserWhereId(GlobalVariable.userTokenId);
      await Provider.of<OrderProvider>(context, listen: false)
          .getAllOrderWhereNoRider();
      await Provider.of<OrderProvider>(context, listen: false)
          .getAllOrderWhereYesRider();
      await Provider.of<OrderProvider>(context, listen: false)
          .getAllOrderWhereRiderDone();
    } else if (GlobalVariable.role == 'customer') {
      await Provider.of<UserProvider>(context, listen: false)
          .getUserWhereId(GlobalVariable.userTokenId);
      await Provider.of<AddressProvider>(context, listen: false)
          .getAllAddressWhereUser();
      await Provider.of<ConfigProvider>(context, listen: false).getAllBanner();
      await Provider.of<ProductProvider>(context, listen: false)
          .getAllProduct();
      await Provider.of<OrderProvider>(context, listen: false)
          .getAllOrderWhereCustomer();
      await Provider.of<ShopProvider>(context, listen: false).getTimeWhereId(1);
      Provider.of<ShopProvider>(context, listen: false).getTimeStatus();
    } else {
      await Provider.of<ConfigProvider>(context, listen: false).getAllBanner();
      await Provider.of<ProductProvider>(context, listen: false)
          .getAllProduct();
      await Provider.of<ShopProvider>(context, listen: false).getTimeWhereId(1);
      Provider.of<ShopProvider>(context, listen: false).getTimeStatus();
    }
    await Provider.of<ShopProvider>(context, listen: false).getAllShop();
    Provider.of<ShopProvider>(context, listen: false).selectShopWhereId(1);
  }
}
