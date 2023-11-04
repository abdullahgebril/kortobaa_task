import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/utils/image_resources.dart';
import 'package:flutter_task/features/cart/cart_view_model.dart';
import 'package:flutter_task/features/cart/widget/requested_purchase_cart.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key, required this.product, required this.cartViewModel});
  final Product product;
  final CartViewModel cartViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSize.h15),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: AppSize.h120,
            // margin: EdgeInsets.only(bottom: AppSize.h15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.h5),
                    topRight: Radius.circular(AppSize.h5)),
                border:
                    Border.all(width: 2.r, color: ColorResources.borderColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(AppSize.h5)),
                  child: CachedNetworkImage(
                    width: AppSize.w140,
                    height: AppSize.h140,
                    imageUrl: product.imageLink,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      ImageResources.placeholder,
                      width: AppSize.w140,
                      height: AppSize.h140,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, __) => Image.asset(
                      ImageResources.placeholder,
                      width: AppSize.w140,
                      height: AppSize.h140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.h10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: FontManager.getMediumStyle(
                            fontSize: 18.sp, color: ColorResources.black),
                      ),
                      Text(
                        "${product.price} ج.م",
                        style: FontManager.getBoldStyle(
                            fontSize: 18.sp,
                            color: ColorResources.primaryColor),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          RequestedPurchaseCart(
            product: product,
            cartViewModel: cartViewModel,
          )
        ],
      ),
    );
  }
}
