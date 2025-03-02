import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class PickLanguageScreen extends StatefulWidget {
  const PickLanguageScreen({super.key});

  @override
  State<PickLanguageScreen> createState() => _PickLanguageScreenState();
}

class _PickLanguageScreenState extends State<PickLanguageScreen> {
  bool themeSwitch = false;

  @override
  Widget build(BuildContext context) {
    PickLanguageAndThemeCubit pickLanguageCubit = context.read<PickLanguageAndThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Language and Theme"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              Text(
                'WELCOME'.tr(context),
                style: TextStyle(fontSize: 25.sp),
                textAlign: TextAlign.center,
              ),
              Text(
                'MONEY_MAKER'.tr(context),
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              Container(
                width: 250.w,
                height: 200.h,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    "Logo will be here",
                    style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'PICK_LANGUAGE'.tr(context),
                style: TextStyle(fontSize: 20.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              PickLanguageButton(
                onTap: () {
                  pickLanguageCubit.changeLanguage(const Locale("en"));
                },
                title: 'ENGLISH',
              ),
              SizedBox(height: 5.h),
              PickLanguageButton(
                onTap: () {
                  pickLanguageCubit.changeLanguage(const Locale("ar"));
                },
                title: 'ARABIC',
              ),
              const Spacer(),
              Text(
                "CHANGE_THEME".tr(context),
                style: TextStyle(fontSize: 17.sp),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mode_night_outlined,
                    size: 40.w,
                  ),
                  SizedBox(width: 5.w),
                  BlocBuilder<PickLanguageAndThemeCubit, PickLanguageAndThemeState>(
                    builder: (context, state) {
                      return Switch(
                        value: themeSwitch,
                        // value: false,
                        onChanged: (value) {
                          themeSwitch = value;
                          setState(() {});
                          pickLanguageCubit.changeTheme(themeSwitch);
                        },
                      );
                    },
                  ),
                  SizedBox(width: 5.w),
                  Icon(
                    Icons.sunny,
                    size: 40.w,
                  )
                ],
              ),
              // SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

class PickLanguageButton extends StatelessWidget {
  const PickLanguageButton({
    super.key,
    required this.onTap,
    required this.title,
  });
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue),
        ),
        child: Center(
          child: Text(
            title.tr(context),
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
