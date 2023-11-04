import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';
import 'package:flutter_task/core/widgets/base_app_bar.dart';
import 'package:flutter_task/core/widgets/custom_button.dart';
import 'package:flutter_task/core/widgets/no_data_screen.dart';
import 'package:flutter_task/features/cart/cart_view_model.dart';
import 'package:flutter_task/features/cart/widget/cart_list.dart';
import 'package:flutter_task/features/cart/widget/cart_total_card.dart';
import 'package:flutter_task/features/cart/widget/coupon_view.dart';
import 'package:flutter_task/features/cart/widget/total_taxes_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartViewModel cartViewModel = CartViewModel();

  @override
  void initState() {
    super.initState();
    cartViewModel.getAllProductsInCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit<bool>, GenericCubitState<bool>>(
      bloc: cartViewModel.cartCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorResources.scaffoldBackgroundColor,
          appBar: const BaseAppBar(title: "shooping_cart"),
          body: cartViewModel.cartList.isEmpty
              ? const NoDataScreen()
              : Padding(
                  padding: EdgeInsets.only(
                      top: AppSize.h30, left: AppSize.w22, right: AppSize.w22),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CartTotalCard(
                          cartViewModel: cartViewModel,
                        ),
                        EmptySpace(space: AppSize.h15),
                        CartListView(
                          cartViewModel: cartViewModel,
                        ),
                        EmptySpace(space: AppSize.h20),
                        const CouponView(),
                        EmptySpace(space: AppSize.h20),
                        TotoLWithTaxes(
                          total: cartViewModel.amount,
                        ),
                        EmptySpace(space: AppSize.h20),
                        CustomButton(
                          title: "complete_purchase",
                          onPressed: () {},
                        ),
                        EmptySpace(space: AppSize.h20),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
