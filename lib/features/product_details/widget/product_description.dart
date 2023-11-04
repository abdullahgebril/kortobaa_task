import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/extensions/media_values.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({super.key, required this.productDescription});

  final String productDescription;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  double _height = AppSize.h48;
  bool _isExpanded = false;

  Future<bool> _showList() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'description'.tr(),
                  style: FontManager.getMediumStyle(
                      fontSize: 16.sp, color: ColorResources.black),
                ),
                InkWell(
                  onTap: () {
                    if (!_isExpanded) {
                      setState(() {
                        _height = context.height * 0.3;
                        _isExpanded = true;
                      });
                    } else {
                      setState(() {
                        _height = AppSize.h48;
                        _isExpanded = false;
                      });
                    }
                  },
                  child: !_isExpanded
                      ? const Icon(Icons.arrow_drop_down)
                      : const Icon(Icons.arrow_drop_up),
                ),
              ],
            ),
          ),
          _isExpanded
              ? FutureBuilder(
                  future: _showList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        widget.productDescription,
                        style: FontManager.getMediumStyle(
                            fontSize: 16.sp, color: ColorResources.black),
                      ),
                    );
                  })
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
