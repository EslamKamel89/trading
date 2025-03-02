import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/firebase_notification/firebase_notification.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/profile/presentation/widgets/decorated_container_user_profile.dart';

class LogoutUserProfile extends StatelessWidget {
  const LogoutUserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Txt.bodyMeduim("LOGOUT".tr(context), fontWeight: FontWeight.bold),
        SizedBox(width: 5.w),
        DecoratedContainerUserProfile(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Txt.bodyMeduim("DO_YOU_WANT_LOGOUT".tr(context)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Txt.bodyMeduim("CANCEL".tr(context)),
                      ),
                      TextButton(
                        onPressed: () async {
                          FirebaseHelper.deleteFcmToken()
                              .then(
                                (value) => sl<SharedPreferences>().clear(),
                              )
                              .then((_) => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(AppRoutesNames.signin, (route) => true));
                        },
                        child: Txt.bodyMeduim("CONFIRM".tr(context)),
                      )
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.logout, color: Clr.f, size: 20.w),
          ),
        ),
        SizedBox(width: 5.w),
        Txt.bodyMeduim('?'.tr(context), fontWeight: FontWeight.bold),
      ],
    );
  }
}
