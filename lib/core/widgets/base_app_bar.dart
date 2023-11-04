import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BaseAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Icon(
        Icons.menu,
        color: ColorResources.grey,
      ),
      centerTitle: true,
      elevation: 2,
      title: Text(
        title.tr(),
        style: FontManager.getMediumStyle(
            fontSize: 16.sp, color: ColorResources.black),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 8.0.w),
          child: Icon(
            Icons.search,
            color: ColorResources.grey,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
