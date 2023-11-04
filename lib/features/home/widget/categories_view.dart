import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/widgets/load_widget.dart';
import 'package:flutter_task/features/home/home_view_model.dart';
import 'package:flutter_task/features/home/widget/category_item.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key, required this.homeViewmodel});
  final HomeViewmodel homeViewmodel;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    widget.homeViewmodel.getCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit<dynamic>, GenericCubitState<dynamic>>(
      bloc: widget.homeViewmodel.categoriesCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return state is GenericLoadingState
            ? const Center(
                child: Loader(),
              )
            : SizedBox(
                height: AppSize.h150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.homeViewmodel.categories.length,
                  itemBuilder: ((context, index) => CategoryItem(
                        category: widget.homeViewmodel.categories[index],
                      )),
                ),
              );
      },
    );
  }
}
