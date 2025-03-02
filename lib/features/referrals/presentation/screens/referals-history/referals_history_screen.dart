import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_image.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/referrals/presentation/blocs/add_refferals_cubit/add_referrals_cubit.dart';

class ReferalsHistoryScreen extends StatefulWidget {
  const ReferalsHistoryScreen({super.key});

  @override
  State<ReferalsHistoryScreen> createState() => _ReferalsHistoryScreenState();
}

class _ReferalsHistoryScreenState extends State<ReferalsHistoryScreen> {
  late final AddReferralsCubit controller;
  @override
  void initState() {
    controller = context.read<AddReferralsCubit>()..getReferralHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // sl<ReferalsRepo>().getReferalsHistory();
    context.watch<PickLanguageAndThemeCubit>();
    return BlocConsumer<AddReferralsCubit, AddReferralsState>(
      listener: (context, state) {
        if (state is ReferralHistoryFailureState) {
          customSnackBar(context: context, title: state.errorMessage, isSuccess: false);
        }
      },
      builder: (context, state) {
        if (state is ReferralHistoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.referalHistory.isEmpty) {
          return Center(
            child: Txt.bodyMeduim("REFERRALS_EMPTY".tr(context)),
          );
        }
        return ListView.builder(
          itemCount: controller.referalHistory.length,
          itemBuilder: (context, index) {
            final referal = controller.referalHistory[index];
            return Container(
              margin: EdgeInsets.only(bottom: 10.w),
              child: Material(
                elevation: 5,
                color: Clr.e,
                borderRadius: BorderRadius.circular(20.w),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  // margin: EdgeInsets.only(bottom: 10.w),
                  // height: 80.h,
                  decoration: BoxDecoration(
                    color: Clr.e,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: ListTile(
                    leading: Builder(builder: (context) {
                      return CustomCircularImage(
                        placeholderAssetPath: AppImages.accountHeader,
                        margin: EdgeInsets.only(left: 5.w, bottom: 5.w, top: 5.w),
                        networkImagePath: '${EndPoint.uploadReferalsHistory}/${referal.referalUserProfile}',
                      );
                    }),
                    title: Txt.bodyMeduim("${referal.referalFirstName}"),
                    trailing: Txt.displayMeduim(referal.createdAt.toString().split(' ')[0]),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
