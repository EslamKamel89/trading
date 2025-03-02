import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/presentation/circular_image.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
    required this.openDrawer,
    required this.imageName,
  });
  final void Function()? openDrawer;
  final String imageName;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularImage(
            imageName: imageName,
            size: 60.w,
          ),
          InkWell(
            onTap: openDrawer,
            child: Icon(
              Icons.menu,
              size: 25.w,
            ),
          )
        ],
      ),
    );
  }
}
