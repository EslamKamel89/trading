import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_image.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';

AppBar mainAppBar({
  required String title,
  required BuildContext context,
  bool automaticallyImplyLeading = true,
  bool transparent = false,
  bool showBackArrow = false,
  PreferredSizeWidget? bottom,
}) {
  final AuthRepo authRepo = sl<AuthRepo>();
  final Future<UserModel?> userModel = authRepo.getChacedUserData();
  return AppBar(
    // title: Txt.headlineMeduim(title),
    leading: showBackArrow
        ? null
        : FutureBuilder(
            future: userModel,
            builder: (context, snapshot) {
              // return Container(
              //   width: 50.w,
              //   height: 50.w,
              //   margin: EdgeInsets.only(left: 10.w, bottom: 5.w),
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //       image: snapshot.connectionState == ConnectionState.done && snapshot.data?.profile != null
              //           ? NetworkImage('${EndPoint.uploadUser}${snapshot.data?.profile}')
              //           : const AssetImage(AppImages.accountHeader) as ImageProvider,
              //       fit: BoxFit.cover,
              //       alignment: Alignment.center,
              //     ),
              //   ),
              // );
              return CustomCircularImage(
                placeholderAssetPath: AppImages.moneyMaker,
                networkImagePath: '${EndPoint.uploadUser}${snapshot.data?.profile}',
                margin: EdgeInsets.only(left: 8.w),
              );
            }),
    title: FutureBuilder(
        future: userModel,
        builder: (context, snapshot) {
          String finalTitle;
          if (title.isNotEmpty) {
            finalTitle = title;
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              finalTitle = snapshot.data?.fullName ?? '';
              finalTitle = finalTitle.split(' ').first;
              finalTitle = "${"WELCOME".tr(context)} $finalTitle";
            } else {
              finalTitle = "WELCOME_USER".tr(context);
            }
          }
          return Txt.bodyMeduim(finalTitle, color: Colors.white);
        }),
    // toolbarHeight: 70.w,
    backgroundColor: transparent ? Colors.transparent : Clr.d,
    automaticallyImplyLeading: automaticallyImplyLeading,
    iconTheme: const IconThemeData(color: Colors.white),
    bottom: bottom,
  );
}
