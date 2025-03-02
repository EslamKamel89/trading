import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

List<Widget> termsAndConditionsCheck(BuildContext context) {
  return [
    Row(
      children: [
        SizedBox(width: 15.w),
        Txt.displayMeduim("READ_TERMS".tr(context)),
        SizedBox(width: 5.w),
        Builder(builder: (context) {
          context.watch<PickLanguageAndThemeCubit>();
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutesNames.termsAndConditions);
            },
            child: Txt.bodyMeduim(
              "HERE".tr(context),
              color: Clr.iconGoldColor,
            ),
          );
        }),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const TermsAndConditionsCheckBox(),
        Txt.displayMeduim("AGREE_TERMS".tr(context)),
      ],
    ),
  ];
}

class TermsAndConditionsCheckBox extends StatefulWidget {
  const TermsAndConditionsCheckBox({
    super.key,
  });

  @override
  State<TermsAndConditionsCheckBox> createState() => _TermsAndConditionsCheckBoxState();
}

class _TermsAndConditionsCheckBoxState extends State<TermsAndConditionsCheckBox> {
  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Checkbox(
      checkColor: Clr.c,
      fillColor: MaterialStatePropertyAll(Clr.d),
      value: SingnupScreen.approveTerms,
      onChanged: (bool? value) {
        SingnupScreen.approveTerms = value!;
        setState(() {});
      },
    );
  }
}
