import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/pick_language_selector.dart';
import 'package:trading/core/presentation/pick_theme_selector.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickLanguageAndThemeCubit, PickLanguageAndThemeState>(
      builder: (context, state) {
        PickLanguageAndThemeCubit controller = context.watch<PickLanguageAndThemeCubit>();
        return Drawer(
          child: Container(
            color: controller.isLightTheme() ? Clr.eLight : Clr.eDark,
            child: ListView(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    // if you change the height of the container remeber to change i below in the
                    // sizedbox widget
                    Container(height: 110.h),
                    ...drawerNavigationButtons(
                      iconData: Octicons.person,
                      title: "USER_PROFILE".tr(context),
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.userProfile, (route) => true);
                      },
                    ),
                    SizedBox(
                      height: 110.h,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          AppImages.moneymakerLogo,
                          height: 70.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),

                ...drawerNavigationButtons(
                  iconData: Octicons.diff_added,
                  title: "ADD_TO_BALANCE".tr(context),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.addBalance, (route) => true);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: Octicons.diff_removed,
                  title: "WITHDRAW_FROM_MAIN_BALANCE".tr(context),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.withdrawMainBalance, (route) => true);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.calendar,
                  title: "WITHDRAW_FROM_WEEKLY_BALANCE".tr(context),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(AppRoutesNames.withdrawWeeklyBalance, (route) => true);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.money,
                  title: "REFERRALS".tr(context),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutesNames.referrals,
                      (route) => true,
                    );
                  },
                ),

                ...drawerNavigationButtons(
                  iconData: Linecons.money,
                  title: "TRNASACTIONS".tr(context),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.transactionHistory, (route) => true);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.newspaper,
                  title: "NOTIFICATIONS_NEWS".tr(context),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.blogNews, (route) => true);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.certificate,
                  title: "LICENSE".tr(context),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.certifications, (route) => true);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.chat,
                  title: "CHAT".tr(context),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutesNames.bottomNavigationScreen,
                      (route) => false,
                      arguments: {'index': 2},
                    );
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.help,
                  title: "SUPPORT".tr(context),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutesNames.bottomNavigationScreen,
                      (route) => false,
                      arguments: {'index': 0},
                    );
                  },
                ),

                SizedBox(height: 10.h),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: PickLanguageSelector(resize: 0.6)),
                    Center(child: PickThemeSelector(resize: 0.6)),
                  ],
                ),
                SizedBox(height: 40.h),
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

List<Widget> drawerNavigationButtons({
  required IconData iconData,
  required String title,
  void Function()? onTap,
}) {
  return [
    Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Clr.f))),
      child: ListTile(
        leading: Icon(
          iconData,
          size: 20.w,
        ),
        title: Txt.displayMeduim(title, size: 12.sp),
        onTap: onTap,
      ),
    ),
    // const Divider(),
  ];
}
