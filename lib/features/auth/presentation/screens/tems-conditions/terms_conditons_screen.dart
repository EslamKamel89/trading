import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/body-widget/body_widget.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/scaffold_gradient_color.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_appbar.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_drawer.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class TermsAndConditonsScreen extends StatelessWidget {
  const TermsAndConditonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return ScaffoldGradientBackgroudAuth(
      child: Scaffold(
        appBar: termsAndConditionsAppBar(title: "TERMS_AND_CONDITIONS".tr(context), context: context),
        backgroundColor: Colors.transparent,
        endDrawer: const AuthDrawer(),
        body: SingleChildScrollView(
          child: BodyWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Txt.headlineMeduim("CONTITIONS_TITLE".tr(context), textAlign: TextAlign.left),
                SizedBox(height: 5.w),
                Txt.bodyMeduim("CONDITIONS_CONTENT".tr(context)),
                SizedBox(height: 10.w),
                Divider(color: Clr.f),
                SizedBox(height: 10.w),
                Txt.headlineMeduim("PRIVACY_TITLE".tr(context), textAlign: TextAlign.left),
                SizedBox(height: 5.w),
                Txt.bodyMeduim("PRIVACY_CONTENT".tr(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
