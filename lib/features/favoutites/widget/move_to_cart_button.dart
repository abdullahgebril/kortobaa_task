import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

class MoveToCartButton extends StatelessWidget {
  const MoveToCartButton(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: AppSize.h50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorResources.primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSize.h5),
                bottomRight: Radius.circular(AppSize.h5))),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style:
                FontManager.getBoldStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
