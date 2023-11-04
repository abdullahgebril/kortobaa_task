import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/features/cart/cart_view_model.dart';

class CartTotalCard extends StatelessWidget {
  const CartTotalCard({
    super.key,
    required this.cartViewModel,
  });

  final CartViewModel cartViewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.h75,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.h5)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.w15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: " ( ${cartViewModel.cartList.length} ) ",
                        style: FontManager.getMediumStyle(
                            fontSize: 18.sp,
                            color: ColorResources.primaryColor)),
                    TextSpan(
                      text: 'عنصر',
                      style: FontManager.getMediumStyle(
                          fontSize: 18.sp, color: ColorResources.black),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "الإجمالي ",
                        style: FontManager.getBoldStyle(
                            fontSize: 18.sp,
                            color: ColorResources.primaryColor)),
                    TextSpan(
                      text: cartViewModel.amount.toStringAsFixed(2),
                      style: FontManager.getMediumStyle(
                          fontSize: 18.sp, color: ColorResources.black),
                    ),
                    TextSpan(
                      text: " ج.م",
                      style: FontManager.getMediumStyle(
                          fontSize: 18.sp, color: ColorResources.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
