import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/widgets/base_app_bar.dart';
import 'package:flutter_task/core/widgets/load_widget.dart';
import 'package:flutter_task/core/widgets/no_data_screen.dart';
import 'package:flutter_task/features/favoutites/favourites_view_model.dart';
import 'package:flutter_task/features/favoutites/widget/favourite_product_item.dart';

class FavProductScreen extends StatefulWidget {
  const FavProductScreen({super.key});

  @override
  State<FavProductScreen> createState() => _FavProductScreenState();
}

class _FavProductScreenState extends State<FavProductScreen> {
  final FavouritesViewModel favouritesViewModel = FavouritesViewModel();

  @override
  void initState() {
    super.initState();
    favouritesViewModel.getFavProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: "favourites"),
      body: BlocConsumer<GenericCubit<bool>, GenericCubitState<bool>>(
        bloc: favouritesViewModel.favProductCubit,
        listener: (context, state) {},
        builder: (context, state) {
          return state is GenericLoadingState
              ? const Center(
                  child: Loader(),
                )
              : favouritesViewModel.favProducts.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSize.h30, horizontal: AppSize.w22),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: favouritesViewModel.favProducts.length,
                      itemBuilder: ((context, index) => FavProductItem(
                            product: favouritesViewModel.favProducts[index],
                            homeViewmodel: favouritesViewModel,
                            favProductState: state,
                          )),
                    )
                  : const NoDataScreen();
        },
      ),
    );
  }
}
