import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/image_resources.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: AppSize.h50,
      height: AppSize.h50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: ColorResources.orangeColor.withOpacity(.5), width: 2),
          image: DecorationImage(
              image: AssetImage(ImageResources.loader), fit: BoxFit.cover)),
    ));
  }
}
