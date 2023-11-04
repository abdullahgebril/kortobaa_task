import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/config/routes/app_route.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/features/cart/model/shop_cart_event.dart';
import 'package:flutter_task/features/categories/categories_page_view.dart';
import 'package:flutter_task/features/favoutites/fav_product_view.dart';
import 'package:flutter_task/features/home/home_view.dart';
import 'package:flutter_task/features/profile/profile_view.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<BottomNavBarPage> {
  int cartLength = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavProductScreen(),
    const ProfileScreen()
  ];
  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.category,
    Icons.favorite,
    Icons.person,
  ];
  final titleList = <String>[
    "home".tr(),
    "categories".tr(),
    "favourites".tr(),
    "profile".tr(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_bottomNavIndex], //destination screen
      floatingActionButton: StreamBuilder<int>(
        initialData: 0,
        stream: ShopCartCountEvent.shopCartEvent,
        builder: (context, snapshot) => FloatingActionButton(
          backgroundColor: ColorResources.orangeColor,
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.shoppingCartPage,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                snapshot.data.toString(),
                style: FontManager.getMediumStyle(
                    fontSize: 16.sp, color: Colors.white),
              ),
              const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: isActive
                      ? ColorResources.primaryColor
                      : ColorResources.grey,
                ),
                Text(
                  titleList[index],
                  style: FontManager.getMediumStyle(
                      fontSize: 14.sp,
                      color: isActive
                          ? ColorResources.primaryColor
                          : ColorResources.grey),
                )
              ],
            ),
          );
        },
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
