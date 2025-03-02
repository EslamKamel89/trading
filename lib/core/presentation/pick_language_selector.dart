import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class PickLanguageSelector extends StatefulWidget {
  const PickLanguageSelector({super.key, this.resize = 1});
  final double resize;
  @override
  State<PickLanguageSelector> createState() => _PickLanguageSelectorState();
}

class _PickLanguageSelectorState extends State<PickLanguageSelector> {
  bool langStatus = false;

  @override
  Widget build(BuildContext context) {
    PickLanguageAndThemeCubit controller = context.watch<PickLanguageAndThemeCubit>();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesome.globe,
            size: widget.resize * 40.w,
            color: Clr.d,
          ),
          SizedBox(width: 10.w),
          FlutterSwitch(
            width: widget.resize * 100.w,
            height: widget.resize * 40.h,
            valueFontSize: widget.resize * 16.sp,
            toggleSize: widget.resize * 40.w,
            value: controller.isEnglishLanguage(),
            borderRadius: widget.resize * 30.0,
            padding: widget.resize * 5.0.w,
            showOnOff: true,
            duration: const Duration(seconds: 1),
            activeText: 'EN',
            inactiveText: 'AR',
            activeColor: Clr.d,
            inactiveColor: Clr.d,
            activeTextColor: Clr.eLight,
            inactiveTextColor: Clr.eLight,
            toggleColor: const Color(0xFF9A3B3B),
            onToggle: (val) {
              setState(() {
                langStatus = val;
              });
              if (langStatus) {
                controller.changeLanguage(const Locale('en'));
              } else {
                controller.changeLanguage(const Locale('ar'));
              }
            },
          ),
        ],
      ),
    );
  }
}
