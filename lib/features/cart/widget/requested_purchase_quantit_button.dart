import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';

class RequestedPurchaseQuantityButton extends StatelessWidget {
  const RequestedPurchaseQuantityButton(
      {super.key,
      required this.rightRaduis,
      required this.onTap,
      required this.backgroundColor,
      required this.iconData});

  final bool rightRaduis;
  final VoidCallback onTap;
  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.h48,
        width: 45.w,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(rightRaduis ? AppSize.h5 : 0))),
        child: Center(
          child: Icon(
            iconData,
            color: Colors.white,
            size: 30.h,
          ),
        ),
      ),
    );
  }
}
