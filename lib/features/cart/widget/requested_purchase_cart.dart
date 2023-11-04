import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/features/cart/cart_view_model.dart';
import 'package:flutter_task/features/cart/widget/requested_purchase_quantit_button.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class RequestedPurchaseCart extends StatelessWidget {
  const RequestedPurchaseCart(
      {super.key, required this.product, required this.cartViewModel});

  final Product product;
  final CartViewModel cartViewModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenericCubit<bool>, GenericCubitState<bool>>(
      bloc: cartViewModel.cartCubit,
      builder: (context, state) {
        return Container(
          color: Colors.white,
          width: double.infinity,
          height: AppSize.h48,
          child: Row(
            children: [
              SizedBox(
                width: AppSize.w140,
                height: AppSize.h48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RequestedPurchaseQuantityButton(
                      rightRaduis: true,
                      backgroundColor: ColorResources.primaryColor,
                      iconData: Icons.add,
                      onTap: () {
                        cartViewModel.increaseRequestedPurchaseQuantity(
                            product, 1);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          product.cartRequestedQuantity.toString(),
                          style: FontManager.getMediumStyle(
                              fontSize: 16.sp, color: ColorResources.black),
                        ),
                      ),
                    ),
                    RequestedPurchaseQuantityButton(
                      onTap: () {
                        cartViewModel.decreaseRequestedPurchaseQuantity(
                            product, 1);
                      },
                      rightRaduis: false,
                      backgroundColor: ColorResources.primaryColor,
                      iconData: Icons.remove,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    cartViewModel.getProductAmount(product).toString(),
                    style: FontManager.getMediumStyle(
                        fontSize: 18.sp, color: ColorResources.black),
                  ),
                ),
              ),
              RequestedPurchaseQuantityButton(
                onTap: () {
                  cartViewModel.askDeleteProductFromCart(context, product);
                },
                rightRaduis: false,
                backgroundColor: ColorResources.orangeColor,
                iconData: Icons.delete_forever,
              ),
            ],
          ),
        );
      },
    );
  }
}
