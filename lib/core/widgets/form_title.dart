import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title.tr(),
          style: FontManager.getMediumStyle(
              fontSize: AppSize.sp16, color: ColorResources.black),
        ),
        SizedBox(
          height: AppSize.h10,
        ),
      ],
    );
  }
}
