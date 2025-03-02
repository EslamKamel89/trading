import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    required this.placeholderAssetPath,
    required this.networkImagePath,
    this.margin,
    this.size = 60,
  });

  final double size;
  final String placeholderAssetPath;
  final EdgeInsetsGeometry? margin;
  final String networkImagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      margin: margin,
      // padding: EdgeInsets.all(5.w),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: FadeInImage.assetNetwork(
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              placeholderAssetPath,
              fit: BoxFit.cover,
              // height: size.w,
            );
          },
          fit: BoxFit.fill,
          height: size.w,
          placeholder: placeholderAssetPath,
          image: networkImagePath),
    );
  }
}

class CustomRectangleImage extends StatelessWidget {
  const CustomRectangleImage({
    super.key,
    required this.placeholderAssetPath,
    required this.networkImagePath,
    this.margin,
    this.width,
    this.height,
    this.borderRadius = 10,
  });
  final double? width;
  final double? height;
  final String placeholderAssetPath;
  final EdgeInsetsGeometry? margin;
  final String networkImagePath;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w,
      height: height?.h,
      margin: margin,
      // padding: EdgeInsets.all(5.w),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(borderRadius.w),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: FadeInImage.assetNetwork(
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              placeholderAssetPath,
              fit: BoxFit.cover,
              height: height?.h,
            );
          },
          fit: BoxFit.fill,
          height: height?.h,
          placeholder: placeholderAssetPath,
          image: networkImagePath),
    );
  }
}
