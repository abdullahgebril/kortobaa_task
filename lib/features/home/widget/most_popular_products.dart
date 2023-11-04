import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';
import 'package:flutter_task/features/cart/cart_view_model.dart';
import 'package:flutter_task/features/home/home_view_model.dart';
import 'package:flutter_task/features/home/widget/product_item.dart';

class MostPopularProductsView extends StatefulWidget {
  const MostPopularProductsView(
      {super.key, required this.homeViewmodel, required this.cartViewModel});
  final HomeViewmodel homeViewmodel;
  final CartViewModel cartViewModel;

  @override
  State<MostPopularProductsView> createState() =>
      _MostPopularProductsViewState();
}

class _MostPopularProductsViewState extends State<MostPopularProductsView> {
  @override
  void initState() {
    super.initState();
    widget.homeViewmodel.getMostPopularProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit<dynamic>, GenericCubitState<dynamic>>(
      bloc: widget.homeViewmodel.mostPopularProductsCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return state is GenericLoadingState
            ? const Center(
                child: SizedBox(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.w15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "most_popular".tr(),
                          style: FontManager.getBoldStyle(
                              fontSize: 18.sp, color: ColorResources.black),
                        ),
                        Text(
                          "view_all".tr(),
                          style: FontManager.getMediumStyle(
                              fontSize: 14.sp, color: ColorResources.black),
                        )
                      ],
                    ),
                    EmptySpace(space: AppSize.h10),
                    SizedBox(
                      height: 260.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.homeViewmodel.mostPopular.length,
                        itemBuilder: ((context, index) => ProductItem(
                              product: widget.homeViewmodel.mostPopular[index],
                              homeViewmodel: widget.homeViewmodel,
                              cartViewModel: widget.cartViewModel,
                            )),
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
