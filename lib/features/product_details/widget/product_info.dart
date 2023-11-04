import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';
import 'package:flutter_task/features/product_details/product_details_view_model.dart';
import 'package:flutter_task/features/product_details/widget/add_product_cart.dart';
import 'package:flutter_task/features/product_details/widget/product_description.dart';
import 'package:flutter_task/features/product_details/widget/product_rate.dart';

class ProductData extends StatelessWidget {
  const ProductData({
    super.key,
    required this.productDetailsViewModel,
  });

  final ProductDetailsViewModel productDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: AppSize.h16, horizontal: AppSize.w22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productDetailsViewModel.product!.name,
            style: FontManager.getMediumStyle(
                fontSize: 18.sp, color: ColorResources.black),
          ),
          EmptySpace(space: AppSize.h15),
          ProductRate(
            productPrice: productDetailsViewModel.product!.price,
            rate: productDetailsViewModel.product!.rate,
          ),
          EmptySpace(space: AppSize.h15),
          const Divider(thickness: 1.0),
          ProductDescription(
            productDescription: productDetailsViewModel.product!.description,
          ),
          const Divider(thickness: 1.0),
          EmptySpace(space: AppSize.h15),
          AddProductToCart(
            product: productDetailsViewModel.product!,
          )
        ],
      ),
    );
  }
}
