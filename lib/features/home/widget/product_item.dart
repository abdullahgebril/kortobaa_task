import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/config/routes/app_route.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/utils/image_resources.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';
import 'package:flutter_task/features/cart/cart_view_model.dart';
import 'package:flutter_task/features/home/home_view_model.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class ProductItem extends StatefulWidget {
  const ProductItem(
      {super.key,
      required this.product,
      required this.homeViewmodel,
      required this.cartViewModel});

  final HomeViewmodel homeViewmodel;
  final CartViewModel cartViewModel;
  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.productDetailsPage,
          arguments: widget.product.id),
      child: SizedBox(
        width: 200.w,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.h5)),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSize.h5),
                        topRight: Radius.circular(AppSize.h5)),
                    child: CachedNetworkImage(
                      width: 200.w,
                      height: 150.h,
                      imageUrl: widget.product.imageLink,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        ImageResources.placeholder,
                        width: 200.w,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, __) => Image.asset(
                        ImageResources.placeholder,
                        width: 200.w,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  BlocBuilder<GenericCubit<bool>, GenericCubitState<bool>>(
                    bloc: widget.homeViewmodel.favProductCubit,
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            widget.homeViewmodel.addFavProduct(
                                status: state.data, product: widget.product);
                          },
                          icon: Icon(
                            widget.product.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.product.isFavourite
                                ? ColorResources.orangeColor
                                : ColorResources.grey,
                            size: 25,
                          ));
                    },
                  )
                ],
              ),
              EmptySpace(space: AppSize.h5),
              Text(
                widget.product.name,
                style: FontManager.getMediumStyle(
                    fontSize: 18.sp, color: ColorResources.black),
              ),
              EmptySpace(space: AppSize.h10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.w10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.product.price} ج.م",
                      style: FontManager.getBoldStyle(
                          fontSize: 18.sp, color: ColorResources.primaryColor),
                    ),
                    BlocBuilder<GenericCubit<bool>, GenericCubitState<bool>>(
                      bloc: widget.cartViewModel.cartCubit,
                      builder: (context, state) {
                        return IconButton(
                            onPressed: () {
                              widget.cartViewModel
                                  .addToCart(state.data, widget.product);
                            },
                            icon: Icon(
                              Icons.shopping_cart_checkout,
                              color: widget.product.isAddedToCart
                                  ? ColorResources.primaryColor
                                  : ColorResources.black,
                            ));
                      },
                    )
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
