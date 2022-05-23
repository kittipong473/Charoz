import 'package:badges/badges.dart';
import 'package:charoz/Screen/Product/Component/Section/drink.dart';
import 'package:charoz/Screen/Product/Component/Section/food.dart';
import 'package:charoz/Screen/Product/Component/Section/snack.dart';
import 'package:charoz/Screen/Product/Component/Section/sweet.dart';
import 'package:charoz/Screen/Product/Provider/product_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final scrollController = ScrollController();
  bool scroll = true;
  double countScore = 0.0;

  Future getData() async {
    Provider.of<ProductProvider>(context, listen: false).getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Positioned.fill(
                top: 15.h,
                child: RefreshIndicator(
                  onRefresh: getData,
                  child: Column(
                    children: [
                      buildChip(),
                      SizedBox(
                        width: 100.w,
                        height: MyVariable.login ? 65.h : 70.h,
                        child: setPage(),
                      ),
                    ],
                  ),
                ),
              ),
              MyWidget().backgroundTitleSearch(),
              MyWidget().title('รายการเมนูอาหาร'),
              MyWidget().buildSearch(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Consumer<ProductProvider>(
            builder: (_, value, __) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                chip('อาหาร', 0, value.productsFoodLength),
                chip('ออร์เดิฟ', 1, value.productsSnackLength),
                chip('เครื่องดื่ม', 2, value.productsDrinkLength),
                chip('ของหวาน', 3, value.productsSweetLength),
              ],
            ),
          ),
          if (MyVariable.role == 'customer') ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                chipOrderCart(),
              ],
            ),
          ] else if (MyVariable.role == 'manager') ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                chipAddProduct(),
              ],
            ),
          ],
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
          });
        },
      ),
    );
  }

  Widget chipOrderCart() {
    return ActionChip(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: MyStyle.blue,
      label: Row(
        children: [
          Icon(
            Icons.shopping_cart_rounded,
            size: 20.sp,
            color: Colors.white,
          ),
          Text(
            'ตะกร้าของคุณ',
            style: MyStyle().boldWhite14(),
          ),
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, RoutePage.routeOrderCart);
      },
    );
  }

  Widget chipAddProduct() {
    return ActionChip(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: MyStyle.blue,
      label: Row(
        children: [
          Icon(
            Icons.add_rounded,
            size: 20.sp,
            color: Colors.white,
          ),
          Text(
            'เพิ่มรายการ',
            style: MyStyle().boldWhite14(),
          ),
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, RoutePage.routeAddProduct);
      },
    );
  }

  Widget setPage() {
    List<Widget> pages = [
      const Food(),
      const Snack(),
      const Drink(),
      const Sweet(),
    ];
    return pages[MyVariable.menuIndex];
  }
}
