import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/config/routes/app_route.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

class LoginText extends StatelessWidget {
  const LoginText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('have_account'.tr(),
            style: FontManager.getMediumStyle(
                fontSize: 16.sp, color: ColorResources.black)),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.loginPage),
          child: Text(
            'sign_in'.tr(),
            style: FontManager.getBoldStyle(
                fontSize: 18.sp,
                color: ColorResources.orangeColor,
                textDecoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
