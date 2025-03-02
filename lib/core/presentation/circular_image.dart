import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({super.key, required this.imageName, this.size});
  final String imageName;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 80.w,
      height: size ?? 80.w,
      margin: EdgeInsets.only(left: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size ?? 80.w),
        image: DecorationImage(
          image: AssetImage(imageName),
        ),
      ),
    );
  }
}
