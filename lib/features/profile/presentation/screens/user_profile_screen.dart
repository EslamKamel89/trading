import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/profile/presentation/widgets/change_password_user_profile.dart';
import 'package:trading/features/profile/presentation/widgets/logout_user_profile.dart';
import 'package:trading/features/profile/presentation/widgets/user_profile_poto.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    final AuthRepo authRepo = sl<AuthRepo>();
    final Future<UserModel?> userModel = authRepo.getChacedUserData();
    return FutureBuilder(
        future: userModel,
        builder: (context, snapshot) {
          return CustomScaffold(
            title: "USER_PROFILE".tr(context),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.infinity, height: 5.h),
                  Center(
                    child: UserProfilePhoto(
                      userModel: userModel,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Txt.bodyMeduim("EMAIL".tr(context), fontWeight: FontWeight.bold),
                  Txt.bodyMeduim(snapshot.data?.email ?? 'jon_doe@example.com', color: Clr.a),
                  SizedBox(height: 15.h),
                  Divider(color: Clr.f),
                  SizedBox(height: 15.h),
                  Txt.bodyMeduim("PHONE_NUMBER".tr(context), fontWeight: FontWeight.bold),
                  Txt.bodyMeduim(snapshot.data?.mobile ?? '+20123456789', color: Clr.a),
                  SizedBox(height: 15.h),
                  Divider(color: Clr.f),
                  SizedBox(height: 15.h),
                  const ChangePasswordUserProfile(),
                  // SizedBox(height: 15.h),
                  Divider(color: Clr.f),
                  SizedBox(height: 15.h),
                  const LogoutUserProfile(),
                ],
              ),
            ),
          );
        });
  }
}




/*
UserModel(id: 6, userName: gamel, fullName: gamel gamel gamel, gender: null, email: gamel@gmail.com, mobile: 012856485584, emailVerifiedAt: null, password: $2y$12$GR8RlLiyqbcQVAA02bSzaeJQlYL5.XZuL/fGCig5FKt9RusAZT.Fa, profile: 1715372327.jpg, passport: 1715372330.jpg, passportBack: 1715372333.jpg, levelId: 2, rememberToken: null, createdAt: 2024-05-10 20:18:56.000Z, updatedAt: 2024-05-10 20:18:56.000Z)
 */
