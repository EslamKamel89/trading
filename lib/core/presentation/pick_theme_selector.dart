import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class PickThemeSelector extends StatefulWidget {
  const PickThemeSelector({super.key, this.resize = 1});
  final double resize;
  @override
  State<PickThemeSelector> createState() => _PickThemeSelectorState();
}

class _PickThemeSelectorState extends State<PickThemeSelector> {
  bool langThemeStatus = false;

  @override
  Widget build(BuildContext context) {
    PickLanguageAndThemeCubit controller = context.watch<PickLanguageAndThemeCubit>();
    // controller.isLightTheme().toString().prm('Pick Theme Selector');
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Entypo.brush,
            size: widget.resize * 40.w,
            color: Clr.d,
          ),
          SizedBox(width: 10.w),
          FlutterSwitch(
            width: widget.resize * 100.w,
            height: widget.resize * 40.h,
            valueFontSize: widget.resize * 16.sp,
            toggleSize: widget.resize * 40.w,
            value: !(controller.isLightTheme()),
            borderRadius: widget.resize * 30.0,
            padding: widget.resize * 5.0.w,
            showOnOff: false,
            duration: const Duration(seconds: 1),
            // activeText: 'EN',
            // inactiveText: 'AR',
            activeIcon: Icon(Iconic.moon, color: Clr.e),
            inactiveIcon: const Icon(Typicons.sun, color: Colors.white),
            activeColor: Clr.d,
            inactiveColor: Clr.d,
            activeTextColor: Clr.eDark,
            inactiveTextColor: Clr.eDark,
            toggleColor: controller.isLightTheme() ? const Color(0xFF9A3B3B).withOpacity(0.5) : const Color(0xFF9A3B3B),
            onToggle: (val) {
              setState(() {
                langThemeStatus = val;
              });
              if (langThemeStatus) {
                controller.changeTheme(false);
              } else {
                controller.changeTheme(true);
              }
            },
          ),
        ],
      ),
    );
  }
}
