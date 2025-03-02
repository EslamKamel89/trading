import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/presentation/pick_language_selector.dart';
import 'package:trading/core/presentation/pick_theme_selector.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class AuthDrawer extends StatelessWidget {
  const AuthDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickLanguageAndThemeCubit, PickLanguageAndThemeState>(
      builder: (context, state) {
        PickLanguageAndThemeCubit controller = context.watch<PickLanguageAndThemeCubit>();
        return Drawer(
          child: Container(
            color: controller.isLightTheme() ? Clr.eLight : Clr.eDark,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 60.h,
                ),
                Center(
                  child: Image.asset(
                    AppImages.moneymakerLogo,
                    height: 200.h,
                    fit: BoxFit.fill,
                  ),
                ),
                Txt.displayMeduim('welcome to Money Maker.\nKindly log in.', size: 15.sp, textAlign: TextAlign.center),
                SizedBox(height: 30.h),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: PickLanguageSelector(resize: 0.6)),
                    Center(child: PickThemeSelector(resize: 0.6)),
                  ],
                ),
                SizedBox(height: 10.h),
                // InkWell(
                //   onTap: () {
                //     Navigator.of(context).pushNamed(AppRoutesNames.testScreen);
                //   },
                //   child: Txt.bodyMeduim("App Colors"),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key, required this.language, required this.onTap, required this.checkedButton});
  final String language;
  final void Function() onTap;
  final bool checkedButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        width: 80.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: checkedButton ? Colors.blue : null,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Center(
          child: Txt.bodyMeduim(language, color: checkedButton ? null : Colors.blue),
        ),
      ),
    );
  }
}

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key, required this.themeType, required this.onTap, required this.checkedButton});
  final String themeType;
  final void Function() onTap;
  final bool checkedButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        // width: 50.w,
        // height: 50.h,
        decoration: BoxDecoration(
          color: checkedButton ? Colors.blue : null,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Center(
          child: Icon(
            themeType == 'light' ? Icons.sunny : Icons.mode_night_outlined,
            size: 40.w,
            color: !checkedButton
                ? Colors.blue
                : themeType == 'light'
                    ? Colors.orange
                    : Colors.white,
          ),
        ),
      ),
    );
  }
}
