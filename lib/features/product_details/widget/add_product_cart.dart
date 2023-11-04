import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/extensions/media_values.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/widgets/Empty_space.dart';
import 'package:flutter_task/features/cart/cart_view_model.dart';
import 'package:flutter_task/features/cart/widget/requested_purchase_quantit_button.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class AddProductToCart extends StatefulWidget {
  const AddProductToCart({super.key, required this.product});

  final Product product;

  @override
  State<AddProductToCart> createState() => _AddProductToCartState();
}

class _AddProductToCartState extends State<AddProductToCart> {
  CartViewModel cartViewModel = CartViewModel();

  @override
  void initState() {
    super.initState();
    cartViewModel.amount = double.parse(widget.product.price);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit<dynamic>, GenericCubitState<dynamic>>(
      bloc: cartViewModel.cartCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
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
                                widget.product, 1);
                          },
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              widget.product.cartRequestedQuantity.toString(),
                              style: FontManager.getMediumStyle(
                                  fontSize: 18.sp, color: ColorResources.black),
                            ),
                          ),
                        ),
                        RequestedPurchaseQuantityButton(
                          onTap: () {
                            cartViewModel.decreaseRequestedPurchaseQuantity(
                                widget.product, 1);
                          },
                          rightRaduis: true,
                          backgroundColor: ColorResources.primaryColor,
                          iconData: Icons.remove,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: Container(
                    height: AppSize.h48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSize.h5),
                    ),
                    child: Center(
                      child: Text(
                        "${cartViewModel.amount.toStringAsFixed(2)} ج.م",
                        style: FontManager.getMediumStyle(
                            fontSize: 16.sp, color: ColorResources.black),
                      ),
                    ),
                  ),
                )
              ],
            ),
            EmptySpace(space: AppSize.h30),
            AddToCartButton(
              cartViewModel: cartViewModel,
              widget: widget,
              state: state,
            )
          ],
        );
      },
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.cartViewModel,
    required this.widget,
    required this.state,
  });

  final CartViewModel cartViewModel;
  final AddProductToCart widget;
  final GenericCubitState<dynamic> state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => cartViewModel.addToCart(state.data, widget.product),
      child: Container(
        height: AppSize.h48,
        width: context.width * 0.35,
        decoration: BoxDecoration(
            color: ColorResources.primaryColor,
            borderRadius: BorderRadius.circular(AppSize.h5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_shopping_cart, color: Colors.white),
            SizedBox(width: 14.w),
            Text(
              "add_to_cart2".tr(),
              style: FontManager.getBoldStyle(
                  fontSize: 14.sp, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
