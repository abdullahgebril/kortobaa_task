import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "look_like_you_have_not_added".tr(),
      style: FontManager.getBoldStyle(
          fontSize: 18.sp, color: ColorResources.black),
    ));
  }
}
