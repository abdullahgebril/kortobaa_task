import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';
import 'package:flutter_task/features/cart/cart_view_model.dart';
import 'package:flutter_task/features/home/home_view_model.dart';
import 'package:flutter_task/features/home/widget/back_drop_fliter_container.dart';
import 'package:flutter_task/features/home/widget/categories_view.dart';
import 'package:flutter_task/features/home/widget/home_app_bar.dart';
import 'package:flutter_task/features/home/widget/most_popular_products.dart';
import 'package:flutter_task/features/home/widget/recent_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewmodel homeViewmodel = HomeViewmodel();
  CartViewModel cartViewModel = CartViewModel();

  @override
  void initState() {
    super.initState();
    cartViewModel.getAllProductsInCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.antiAlias,
                children: <Widget>[
                  BackDropFliterContainer(
                    homeViewmodel: homeViewmodel,
                  ),
                  HomeAppBar(
                    homeViewmodel: homeViewmodel,
                  ),
                ],
              ),
              CategoriesView(homeViewmodel: homeViewmodel),
              RecentProduct(
                homeViewmodel: homeViewmodel,
                cartViewModel: cartViewModel,
              ),
              EmptySpace(space: AppSize.h30),
              MostPopularProductsView(
                homeViewmodel: homeViewmodel,
                cartViewModel: cartViewModel,
              ),
              EmptySpace(space: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
