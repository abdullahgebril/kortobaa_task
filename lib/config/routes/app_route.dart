import 'package:flutter/material.dart';
import 'package:flutter_task/features/cart/cart_view.dart';
import 'package:flutter_task/features/home/home_view.dart';
import 'package:flutter_task/features/bottom_navigation_bar/bottom_nav_bar_page.dart';
import 'package:flutter_task/features/login/login_view.dart';
import 'package:flutter_task/features/product_details/product_details_view.dart';
import 'package:flutter_task/features/registration/registration_view.dart';

class AppRoutes {
  // All app routes
  static const String splashPage = "splashPage";
  static const String loginPage = "loginPage";
  static const String registrationPage = "registrationPage";
  static const String homePage = "homePage";
  static const String navigationScreen = "navigationScreen";
  static const String shoppingCartPage = "shoppingCartPage";
  static const String productDetailsPage = "productDetails";

  static Route<dynamic> appRoutes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case loginPage:
        return appPage(const LoginScreen());
      case registrationPage:
        return appPage(const RegistrationScreen());
      case homePage:
        return appPage(const HomeScreen());
      case navigationScreen:
        return appPage(const BottomNavBarPage());
      case shoppingCartPage:
        return appPage(const CartScreen());
      case productDetailsPage:
        return appPage(ProductDetailsScreen(
          productID: args as int,
        ));

      default:
        return appPage(const LoginScreen());
    }
  }

  static appPage(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
