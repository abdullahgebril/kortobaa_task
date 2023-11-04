import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/features/home/home_view_model.dart';
import 'package:flutter_task/features/home/widget/banners_view.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.homeViewmodel});

  final HomeViewmodel homeViewmodel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: AppSize.h16, vertical: AppSize.h36),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.menu,
                size: 30,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "home".tr(),
                    style:
                        FontManager.getMediumStyle(color: ColorResources.black),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSize.h10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "search".tr(),
                  hintStyle:
                      FontManager.getMediumStyle(color: ColorResources.black),
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(AppSize.h20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppSize.h10,
          ),
          BannersView(
            homeViewmodel: homeViewmodel,
          )
        ],
      ),
    );
  }
}
