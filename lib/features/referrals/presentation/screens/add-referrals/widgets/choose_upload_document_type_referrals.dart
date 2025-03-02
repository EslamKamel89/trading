import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/referrals/presentation/blocs/add_refferals_cubit/add_referrals_cubit.dart';

class ChooseUploadDocumentTypeReferrals extends StatefulWidget {
  const ChooseUploadDocumentTypeReferrals({super.key});

  @override
  State<ChooseUploadDocumentTypeReferrals> createState() => _ChooseUploadDocumentTypeReferralsState();
}

class _ChooseUploadDocumentTypeReferralsState extends State<ChooseUploadDocumentTypeReferrals> {
  @override
  Widget build(BuildContext context) {
    AddReferralsCubit controller = context.read<AddReferralsCubit>();
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Txt.displayMeduim("PERSONAL_ID".tr(context)),
              SizedBox(width: 5.w),
              Switch(
                value: controller.isUploadPassport,
                onChanged: (value) {
                  controller.isUploadPassport = value;
                  setState(() {});
                },
                activeColor: const Color(0xFFE9C874),
                inactiveThumbColor: const Color(0xFFE9C874),
                inactiveTrackColor: const Color(0xFFA34343),
              ),
              SizedBox(width: 5.w),
              Txt.displayMeduim("PASSPORT".tr(context)),
            ],
          ),
          controller.isUploadPassport
              ? Txt.displayMeduim(
                  "UPLOAD_ONE_PHOTO".tr(context),
                  textAlign: TextAlign.center,
                )
              : Txt.bodyMeduim(
                  "UPLOAD_TWO_PHOTO".tr(context),
                  textAlign: TextAlign.center,
                )
        ],
      ),
    );
  }
}
