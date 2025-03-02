import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/referrals/presentation/blocs/add_refferals_cubit/add_referrals_cubit.dart';

class UploadPassportStatusReferals extends StatelessWidget {
  const UploadPassportStatusReferals({super.key});

  @override
  Widget build(BuildContext context) {
    AddReferralsCubit controller = context.read<AddReferralsCubit>();
    // return const SizedBox();
    return BlocBuilder<AddReferralsCubit, AddReferralsState>(
      buildWhen: (previous, current) {
        return current is UpdateDoucumentImageReferralsState ? true : false;
      },
      builder: (context, state) {
        if (controller.isUploadPassport) {
          return SizedBox(
            child: controller.uploadIdDocumentFileOne != null
                ? const UploadDocumentSuccessRefferals()
                : const UploadDocumentFailureRefferals(),
          );
        } else {
          return SizedBox(
            child: controller.uploadIdDocumentFileOne != null && controller.uploadIdDocumentFileTwo != null
                ? const UploadDocumentSuccessRefferals()
                : const UploadDocumentFailureRefferals(),
          );
        }
      },
    );
  }
}

class UploadDocumentFailureRefferals extends StatelessWidget {
  const UploadDocumentFailureRefferals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return const SizedBox();
    final controller = context.read<AddReferralsCubit>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.error, size: 30.w, color: Colors.red),
        SizedBox(width: 5.w),
        Txt.displayMeduim(
          controller.isUploadPassport ? "DIDNT_UPLOAD_DOCUMENT".tr(context) : "UPLOAD_TWO_PHOTO".tr(context),
          color: Colors.red,
        ),
      ],
    );
  }
}

class UploadDocumentSuccessRefferals extends StatelessWidget {
  const UploadDocumentSuccessRefferals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return const SizedBox();
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.check, size: 30.w, color: Colors.green),
        SizedBox(width: 5.w),
        Txt.displayMeduim(
          'Documents Uploaded Successfuly',
          color: Colors.green,
        ),
      ],
    );
  }
}
