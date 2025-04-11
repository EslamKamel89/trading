import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/firebase_notification/firebase_notification.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Txt.bodyMeduim("DO_YOU_WANT_DELETE_ACCOUNT".tr(context)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Txt.bodyMeduim("CANCEL".tr(context)),
                      ),
                      TextButton(
                        onPressed: () async {
                          Future.delayed(const Duration(seconds: 1), () async {
                            const url = 'https://money.iuceg.com/delete-account';
                            await launchUrl(Uri.parse(url));
                          });
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
            child: Txt.bodyMeduim("DELETE".tr(context),
                fontWeight: FontWeight.bold, color: Colors.red)),
        // SizedBox(width: 5.w),
        // DecoratedContainerUserProfile(
        //   child: InkWell(
        //     onTap: () {
        //       showDialog(
        //         context: context,
        //         builder: (context) {
        //           return AlertDialog(
        //             title: Txt.bodyMeduim("DO_YOU_WANT_DELETE_ACCOUNT".tr(context)),
        //             actions: [
        //               TextButton(
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: Txt.bodyMeduim("CANCEL".tr(context)),
        //               ),
        //               TextButton(
        //                 onPressed: () async {
        //                   Future.delayed(const Duration(seconds: 1), () async {
        //                     const url = 'https://money.iuceg.com/delete-account';
        //                     await launchUrl(Uri.parse(url));
        //                   });
        //                   FirebaseHelper.deleteFcmToken()
        //                       .then(
        //                         (value) => sl<SharedPreferences>().clear(),
        //                       )
        //                       .then((_) => Navigator.of(context)
        //                           .pushNamedAndRemoveUntil(AppRoutesNames.signin, (route) => true));
        //                 },
        //                 child: Txt.bodyMeduim("CONFIRM".tr(context)),
        //               )
        //             ],
        //           );
        //         },
        //       );
        //     },
        //     child: Icon(Icons.dangerous, color: Colors.red, size: 20.w),
        //   ),
        // ),
        SizedBox(width: 5.w),
        Txt.bodyMeduim('?'.tr(context), fontWeight: FontWeight.bold),
      ],
    );
  }
}
