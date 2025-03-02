// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';

class UploadPassportStatus extends StatelessWidget {
  const UploadPassportStatus({super.key});

  @override
  Widget build(BuildContext context) {
    SignupCubit controller = context.read<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return current is UpdateDoucumentImageState ? true : false;
      },
      builder: (context, state) {
        if (controller.isUploadPassport) {
          return SizedBox(
            child: controller.uploadIdDocumentFileOne != null
                ? const UploadDocumentSuccess()
                : const UploadDocumentFailure(),
          );
        } else {
          return SizedBox(
            child: controller.uploadIdDocumentFileOne != null && controller.uploadIdDocumentFileTwo != null
                ? const UploadDocumentSuccess()
                : const UploadDocumentFailure(),
          );
        }
      },
    );
  }
}

class UploadDocumentFailure extends StatelessWidget {
  const UploadDocumentFailure({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SignupCubit>();
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

class UploadDocumentSuccess extends StatelessWidget {
  const UploadDocumentSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
