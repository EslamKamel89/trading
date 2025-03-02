import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class GenderSelection extends StatefulWidget {
  const GenderSelection({
    super.key,
    required this.genderValue,
    required this.label,
  });
  final String genderValue;
  final String label;
  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  @override
  Widget build(BuildContext context) {
    final pickLanguageCubit = context.read<PickLanguageAndThemeCubit>();
    final signupController = context.read<SignupCubit>();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15.h),
          padding: EdgeInsets.only(
            left: pickLanguageCubit.isEnglishLanguage() ? 10.w : 0,
            right: pickLanguageCubit.isEnglishLanguage() ? 0 : 10.w,
            top: 5.h,
          ),
          height: 55.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(color: Clr.iconGoldColor),
          ),
          child: DropdownButton(
            underline: const SizedBox(),
            items: [
              DropdownMenuItem<String>(value: "male", child: Txt.displayMeduim("MALE".tr(context), color: Clr.d)),
              DropdownMenuItem<String>(value: "female", child: Txt.displayMeduim("FEMALE".tr(context), color: Clr.d)),
            ],
            value: SingnupScreen.genderValue,
            onChanged: (value) {
              SingnupScreen.genderValue = value.toString();
              if (value == 'male') {
                signupController.isMale = true;
              } else if (value == 'female') {
                signupController.isMale = false;
              }
              setState(() {});
            },
            iconSize: 30.w,
            // iconEnabledColor: Colors.blue,
            icon: SingnupScreen.genderValue == "male"
                ? Icon(Icons.male, color: Clr.iconGoldColor)
                : Icon(Icons.female, color: Clr.iconGoldColor),
            isExpanded: true,
            // style: const TextStyle(color: Colors.blue),
          ),
        ),
        Positioned(
          left: pickLanguageCubit.isEnglishLanguage() ? 5.w : null,
          right: pickLanguageCubit.isEnglishLanguage() ? null : 5.w,
          top: -8.h,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Txt.bodyMeduim(' ${widget.label} '),
          ),
        ),
      ],
    );
  }
}
