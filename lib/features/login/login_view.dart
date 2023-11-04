import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/utils/image_resources.dart';
import 'package:flutter_task/features/login/widget/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSize.h95, horizontal: AppSize.w24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageResources.loginLogo,
                  width: AppSize.w128,
                  height: AppSize.h95,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: AppSize.h10,
                ),
                Text(
                  "sign_in".tr(),
                  style: FontManager.getBoldStyle(
                      fontSize: AppSize.sp18,
                      color: ColorResources.orangeColor),
                ),
                SizedBox(
                  height: AppSize.h10,
                ),
                Text(
                  "login_title".tr(),
                  style: FontManager.getBoldStyle(
                      fontSize: AppSize.sp14, color: ColorResources.black),
                ),
                SizedBox(
                  height: AppSize.h48,
                ),
                const LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
