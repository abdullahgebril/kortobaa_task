import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';

class ProductRate extends StatefulWidget {
  const ProductRate(
      {super.key, required this.productPrice, required this.rate});

  final String productPrice;
  final String rate;

  @override
  State<ProductRate> createState() => _ProductRateState();
}

class _ProductRateState extends State<ProductRate> {
  double currentRate = 0;
  @override
  void initState() {
    super.initState();
    currentRate = double.parse(widget.rate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${widget.productPrice} ج.م",
          style: FontManager.getMediumStyle(
              fontSize: 18.sp, color: ColorResources.primaryColor),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.rate,
              style: FontManager.getMediumStyle(
                  fontSize: 16.sp, color: ColorResources.black),
            ),
            RatingBar.builder(
              initialRating: currentRate,
              minRating: 1,
              ignoreGestures: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 1,
              itemSize: 22,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
                size: 5,
              ),
              onRatingUpdate: (rating) {},
            ),
          ],
        )
      ],
    );
  }
}
