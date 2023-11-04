import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: AppFontWeight.fontFamily,
    primaryColor: ColorResources.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorResources.scaffoldBackgroundColor,
    cardColor: Colors.white,
    hintColor: ColorResources.orangeColor,
    focusColor: ColorResources.orangeColor,
    canvasColor: ColorResources.orangeColor,

    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    }),

    ///elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 45.h),
        textStyle:
            FontManager.getBoldStyle(fontSize: 16.sp, color: Colors.white),
        backgroundColor: ColorResources.primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    ),
  );
}
