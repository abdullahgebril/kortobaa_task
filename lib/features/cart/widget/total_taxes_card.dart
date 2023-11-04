import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';

class TotoLWithTaxes extends StatelessWidget {
  const TotoLWithTaxes({super.key, required this.total});
  final double total;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.h5),
      ),
      child: Column(
        children: [
          TotalValueView(
            title: 'total'.tr(),
            value: total,
          ),
          EmptySpace(space: AppSize.h15),
          TotalValueView(
            title: 'taxes'.tr(),
            value: 5.00,
          ),
          Divider(
            thickness: 1,
            color: ColorResources.grey,
          ),
          TotalValueView(
            title: 'total'.tr(),
            value: total + 5.00,
          ),
        ],
      ),
    );
  }
}

class TotalValueView extends StatelessWidget {
  const TotalValueView({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: FontManager.getBoldStyle(
                fontSize: 16.sp, color: ColorResources.primaryColor),
          ),
          Text(
            "${value.toStringAsFixed(2)} ج.م",
            style: FontManager.getMediumStyle(
                fontSize: 16.sp, color: ColorResources.black),
          )
        ],
      ),
    );
  }
}
