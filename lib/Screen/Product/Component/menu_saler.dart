import 'package:badges/badges.dart';
import 'package:charoz/Screen/Product/Component/Section/drink.dart';
import 'package:charoz/Screen/Product/Component/Section/food.dart';
import 'package:charoz/Screen/Product/Component/Section/snack.dart';
import 'package:charoz/Screen/Product/Component/Section/sweet.dart';
import 'package:charoz/Screen/Product/Model/product_model.dart';
import 'package:charoz/Screen/Product/Provider/product_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuSaler extends StatefulWidget {
  const MenuSaler({Key? key}) : super(key: key);

  @override
  _MenuSalerState createState() => _MenuSalerState();
}

class _MenuSalerState extends State<MenuSaler> {
  final scrollController = ScrollController();
  List<ProductModel> favorites = [];
  bool data = false;
  bool scroll = true;
  double countScore = 0.0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Provider.of<ProductProvider>(context, listen: false).getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<ProductProvider>(
          builder: (context, pprovider, child) => pprovider
                  .productsSweet.isEmpty
              ? const ShowProgress()
              : GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  behavior: HitTestBehavior.opaque,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: 15.h,
                        child: Column(
                          children: [
                            buildChip(pprovider),
                            SizedBox(
                              width: 100.w,
                              height: 65.h,
                              child: setPage(MyVariable.menuIndex, pprovider),
                            ),
                          ],
                        ),
                      ),
                      MyWidget().backgroundTitleSearch(),
                      MyWidget().title('รายการเมนูอาหาร'),
                      MyWidget().buildSearch(context),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildChip(ProductProvider pprovider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              chip('อาหาร', 0, pprovider.productsFoodLength),
              chip('ออร์เดิฟ', 1, pprovider.productsSnackLength),
              chip('เครื่องดื่ม', 2, pprovider.productsDrinkLength),
              chip('ของหวาน', 3, pprovider.productsSweetLength),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chipAddMenu(),
            ],
          ),
        ],
      ),
    );
  }

  Widget chip(String title, int index, int length) {
    return Badge(
      badgeContent: Text(
        length.toString(),
        style: MyStyle().boldWhite14(),
      ),
      badgeColor: Colors.blue,
      padding: const EdgeInsets.all(8),
      child: ActionChip(
        backgroundColor: MyVariable.menuIndex == index
            ? MyStyle.primary
            : Colors.grey.shade300,
        label: Text(
          title,
          style: MyVariable.menuIndex == index
              ? MyStyle().boldWhite14()
              : MyStyle().boldBlack14(),
        ),
        onPressed: () {
          setState(() {
            MyVariable.menuIndex = index;
            MyVariable.menuType = title;
          });
        },
      ),
    );
  }

  Widget chipAddMenu() {
    return ActionChip(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: Colors.green,
      label: Row(
        children: [
          Icon(
            Icons.add_rounded,
            size: 20.sp,
            color: Colors.white,
          ),
          Text(
            'เพิ่มรายการอาหาร',
            style: MyStyle().boldWhite14(),
          ),
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, RoutePage.routeAddProduct);
      },
    );
  }

  Widget setPage(int indexPage, ProductProvider pprovider) {
    List<Widget> pages = [
      Food(productFoods: pprovider.productsFood),
      Snack(productSnacks: pprovider.productsSnack),
      Drink(productDrinks: pprovider.productsDrink),
      Sweet(productSweets: pprovider.productsSweet),
    ];
    return pages[indexPage];
  }
}
