import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/extensions/media_values.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';
import 'package:flutter_task/core/widgets/custom_network_image.dart';
import 'package:flutter_task/features/favoutites/favourites_view_model.dart';
import 'package:flutter_task/features/favoutites/widget/move_to_cart_button.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class FavProductItem extends StatelessWidget {
  const FavProductItem({
    super.key,
    required this.product,
    required this.homeViewmodel,
    required this.favProductState,
  });

  final Product product;
  final FavouritesViewModel homeViewmodel;
  final GenericCubitState<bool> favProductState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.45,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.h5)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomNetworkImage(
                      imageUrl: product.imageLink,
                      height: context.height * 0.225,
                      width: double.infinity,
                      raduis: AppSize.h5,
                    ),
                    IconButton(
                      onPressed: () {
                        homeViewmodel.addFavProduct(
                            status: favProductState.data, product: product);
                      },
                      icon: Icon(
                        product.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavourite
                            ? ColorResources.orangeColor
                            : ColorResources.grey,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.w15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: FontManager.getMediumStyle(
                            fontSize: 20.sp, color: ColorResources.black),
                      ),
                      EmptySpace(space: 15.h),
                      Text(
                        "${product.price} ج.م",
                        style: FontManager.getBoldStyle(
                            fontSize: 18.sp,
                            color: ColorResources.primaryColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: MoveToCartButton(
                  title: "move_to_cart".tr(),
                  onPressed: () {},
                ))
          ],
        ),
      ),
    );
  }
}
