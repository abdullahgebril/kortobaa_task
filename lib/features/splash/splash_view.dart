import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/config/routes/app_route.dart';
import 'package:flutter_task/core/cache/cache_manger.dart';
import 'package:flutter_task/core/extensions/media_values.dart';
import 'package:flutter_task/core/utils/app_constants.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (CacheManager.contains(AppConstants.ACCESS_TOKEN)) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.navigationScreen, (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.loginPage, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: context.width * 0.8,
          child: TextLiquidFill(
            text: 'KORTOBAA',
            waveColor: ColorResources.primaryColor,
            textAlign: TextAlign.right,
            boxBackgroundColor: ColorResources.scaffoldBackgroundColor,
            textStyle: TextStyle(
                fontSize: AppSize.sp45,
                fontWeight: FontWeight.bold,
                color: ColorResources.orangeColor),
            boxHeight: context.width * 0.6,
          ),
        ),
      ),
    );
  }
}
