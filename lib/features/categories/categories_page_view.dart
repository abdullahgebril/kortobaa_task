import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/widgets/base_app_bar.dart';
import 'package:flutter_task/core/widgets/load_widget.dart';
import 'package:flutter_task/features/categories/widget/category_page_item.dart';
import 'package:flutter_task/features/home/home_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final HomeViewmodel homeViewmodel = HomeViewmodel();

  @override
  void initState() {
    super.initState();
    homeViewmodel.getCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit<dynamic>, GenericCubitState<dynamic>>(
      bloc: homeViewmodel.categoriesCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: const BaseAppBar(title: "categories"),
          body: state is GenericLoadingState
              ? const Center(
                  child: Loader(),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSize.h30, horizontal: AppSize.w22),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: homeViewmodel.categories.length,
                  itemBuilder: ((context, index) => CategoryItem(
                        category: homeViewmodel.categories[index],
                      )),
                ),
        );
      },
    );
  }
}
