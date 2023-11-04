import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

class CutomFavButton extends StatelessWidget {
  const CutomFavButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.backgroundColor});

  final String title;
  final IconData icon;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.w10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: backgroundColor,
            size: 25,
          ),
          SizedBox(width: 5.w),
          Text(
            title,
            style: FontManager.getMediumStyle(
                fontSize: 16.sp, color: backgroundColor),
          ),
        ],
      ),
    );
  }
}
