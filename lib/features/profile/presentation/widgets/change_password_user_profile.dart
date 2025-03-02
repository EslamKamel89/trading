import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/profile/presentation/widgets/decorated_container_user_profile.dart';
import 'package:trading/features/profile/presentation/widgets/password_text_field_user_profile.dart';

class ChangePasswordUserProfile extends StatefulWidget {
  const ChangePasswordUserProfile({
    super.key,
  });

  @override
  State<ChangePasswordUserProfile> createState() => _ChangePasswordUserProfileState();
}

class _ChangePasswordUserProfileState extends State<ChangePasswordUserProfile> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Txt.bodyMeduim("CHANGE_YOUR".tr(context), fontWeight: FontWeight.bold),
            SizedBox(width: 5.w),
            InkWell(
              onTap: () {
                showPassword = !showPassword;
                setState(() {});
              },
              child: DecoratedContainerUserProfile(
                child: Txt.bodyMeduim("PASSWORD".tr(context), color: Clr.f, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 5.w),
            Txt.bodyMeduim('?'.tr(context), fontWeight: FontWeight.bold),
          ],
        ),
        // ),
        Visibility(
          visible: showPassword,
          child: PasswordTextFieldUserProfile(hintText: "ENTER_OLD_PASSWORD".tr(context)),
        ),
        Visibility(
          visible: showPassword,
          child: PasswordTextFieldUserProfile(hintText: "ENTER_NEW_PASSWORD_PROFILE".tr(context)),
        ),
        Visibility(
          visible: showPassword,
          child: PasswordTextFieldUserProfile(hintText: "REENTER_NEW_PASSWORD".tr(context)),
        ),
        Visibility(
          visible: showPassword,
          child: InkWell(
            onTap: () {
              showPassword = !showPassword;
              setState(() {});
            },
            child: DecoratedContainerUserProfile(
              verticalMargin: 15.h,
              child: Txt.bodyMeduim("SAVE_PASSWORD".tr(context), color: Clr.f),
            ),
          ),
        ),
        Visibility(visible: !showPassword, child: SizedBox(height: 15.h)),
      ],
    );
  }
}
