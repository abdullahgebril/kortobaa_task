import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/extensions/media_values.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/widgets/custom_network_image.dart';
import 'package:flutter_task/core/widgets/load_widget.dart';
import 'package:flutter_task/features/product_details/product_details_view_model.dart';
import 'package:flutter_task/features/product_details/widget/fav_share_button.dart';
import 'package:flutter_task/features/product_details/widget/product_info.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productID});

  final int productID;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsViewModel productDetailsViewModel = ProductDetailsViewModel();

  @override
  void initState() {
    super.initState();
    productDetailsViewModel.getProductDetails(context, widget.productID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit<dynamic>, GenericCubitState<dynamic>>(
      bloc: productDetailsViewModel.productDetailsCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorResources.scaffoldBackgroundColor,
          body: state is GenericLoadingState
              ? const Center(
                  child: Loader(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CustomNetworkImage(
                            imageUrl:
                                productDetailsViewModel.product!.imageLink,
                            raduis: 0,
                            height: context.height * 0.4,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppSize.h30, horizontal: AppSize.w4),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                )),
                          )
                        ],
                      ),
                      favAndShareButton(),
                      ProductData(
                          productDetailsViewModel: productDetailsViewModel)
                    ],
                  ),
                ),
        );
      },
    );
  }

  Container favAndShareButton() {
    return Container(
      width: double.infinity,
      height: AppSize.h50,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child:
                BlocBuilder<GenericCubit<dynamic>, GenericCubitState<dynamic>>(
              bloc: productDetailsViewModel.favProductCubit,
              builder: (context, state) {
                return InkWell(
                  onTap: () => productDetailsViewModel.addFavProduct(
                      status: state.data,
                      product: productDetailsViewModel.product!),
                  child: CutomFavButton(
                    title: productDetailsViewModel.isProductInFavourites()
                        ? "added_to_favorites".tr()
                        : 'add_to_favorites'.tr(),
                    icon: productDetailsViewModel.isProductInFavourites()
                        ? Icons.favorite
                        : Icons.favorite_border,
                    backgroundColor:
                        productDetailsViewModel.isProductInFavourites()
                            ? ColorResources.orangeColor
                            : ColorResources.black,
                  ),
                );
              },
            ),
          ),
          Container(
            height: AppSize.h48,
            width: 3,
            color: ColorResources.grey,
          ),
          Expanded(
            child: CutomFavButton(
              title: 'share'.tr(),
              icon: Icons.share,
              backgroundColor: ColorResources.black,
            ),
          ),
        ],
      ),
    );
  }
}
