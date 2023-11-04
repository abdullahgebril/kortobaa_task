import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/extensions/media_values.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/utils/image_resources.dart';
import 'package:flutter_task/features/home/model/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSize.h24),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.h5),
            child: CachedNetworkImage(
              width: double.infinity,
              height: AppSize.h150,
              imageUrl: category.imageLink,
              fit: BoxFit.fill,
              placeholder: (context, url) => Image.asset(
                ImageResources.placeholder,
                width: double.infinity,
                height: AppSize.h150,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, __) => Image.asset(
                ImageResources.placeholder,
                width: double.infinity,
                height: AppSize.h150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: AppSize.h150 / 2,
              left: context.width / 3,
              child: Text(
                category.name,
                style: FontManager.getMediumStyle(
                    fontSize: 24.sp, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
