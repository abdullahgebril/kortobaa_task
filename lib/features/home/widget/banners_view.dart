import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/extensions/media_values.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/features/home/home_view_model.dart';

class BannersView extends StatelessWidget {
  const BannersView({super.key, required this.homeViewmodel});

  final HomeViewmodel homeViewmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: context.width,
          height: context.width * 0.4,
          child: CarouselSlider.builder(
            itemCount: homeViewmodel.banners.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                homeViewmodel.banners[itemIndex],
                width: context.width,
                height: context.width * 0.4,
              ),
            ),
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              disableCenter: true,
              onPageChanged: (index, reason) {
                homeViewmodel.setBannerIndex(index);
              },
            ),
          ),
        ),
        SizedBox(
          height: AppSize.h12,
        ),
        BlocConsumer<GenericCubit, GenericCubitState>(
          bloc: homeViewmodel.bannerCubit,
          listener: (context, state) {},
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: homeViewmodel.banners.map((bnr) {
                int index = homeViewmodel.banners.indexOf(bnr);
                return Container(
                  width: AppSize.w15,
                  height: 4,
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: index == homeViewmodel.bannerIndex
                        ? ColorResources.primaryColor
                        : ColorResources.grey,
                    shape: BoxShape.rectangle,
                  ),
                );
              }).toList(),
            );
          },
        )
      ],
    );
  }
}
