import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainpageNavigationButton extends StatelessWidget {
  const MainpageNavigationButton({
    super.key,
    required this.child,
    required this.routeName,
    required this.color,
  });
  final Widget child;
  final String routeName;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
        decoration: BoxDecoration(
            color: Colors.transparent,
            // border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(10.w),
            boxShadow: [
              BoxShadow(
                color: color,
                blurRadius: 5.w,
                blurStyle: BlurStyle.outer,
              ),
            ]),
        child: child,
      ),
    );
  }
}
