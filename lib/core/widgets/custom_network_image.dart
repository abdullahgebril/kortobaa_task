import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/utils/image_resources.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
      {super.key,
      required this.raduis,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.fit});
  final double raduis;
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(raduis),
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUrl,
        fit: BoxFit.fill,
        placeholder: (context, url) => Image.asset(
          ImageResources.placeholder,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, __) => Image.asset(
          ImageResources.placeholder,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
