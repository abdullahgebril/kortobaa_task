import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task/core/extensions/media_values.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

import 'package:flutter_task/core/utils/image_resources.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';

class CouponView extends StatelessWidget {
  const CouponView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.h120,
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.antiAlias,
        children: [
          SvgPicture.asset(ImageResources.coupon,
              semanticsLabel: 'A red up arrow'),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: AppSize.h10, horizontal: AppSize.w15),
            width: context.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.w30),
                  child: Text(
                    "have_discount_coupon".tr(),
                    style: FontManager.getBoldStyle(
                        fontSize: 16.sp, color: Colors.white),
                  ),
                ),
                EmptySpace(space: AppSize.h15),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: AppSize.h48,
                        decoration: BoxDecoration(
                            color: ColorResources.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(AppSize.h5)),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: AppSize.h10),
                            hintText: "enter_coupon_code".tr(),
                            hintStyle: FontManager.getMediumStyle(
                                fontSize: 14.sp, color: ColorResources.black),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: AppSize.h48,
                      width: AppSize.w96,
                      margin: EdgeInsets.only(right: AppSize.w15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.h5),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "apply".tr(),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: FontManager.getBoldStyle(
                              fontSize: 18.sp, color: ColorResources.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
