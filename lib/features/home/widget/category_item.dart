import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/utils/image_resources.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';
import 'package:flutter_task/features/home/model/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.w15),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.h40),
            child: CachedNetworkImage(
              width: 60,
              height: 60,
              imageUrl: category.imageLink,
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset(
                ImageResources.placeholder,
                width: AppSize.w60,
                height: AppSize.h60,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, __) => Image.asset(
                ImageResources.placeholder,
                width: AppSize.w60,
                height: AppSize.h60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          EmptySpace(space: AppSize.h10),
          Text(
            category.name,
            style: FontManager.getMediumStyle(
                fontSize: 14.sp, color: ColorResources.black),
          )
        ],
      ),
    );
  }
}
