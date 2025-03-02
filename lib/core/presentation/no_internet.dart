import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/balance/presentation/widgets/paymet_button.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
    required this.errorMessage,
    this.refreshCallback,
  });

  final String errorMessage;
  final void Function()? refreshCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.noInternet, width: 200.w, height: 200.w, fit: BoxFit.cover),
        SizedBox(height: 10.h),
        Center(child: Txt.bodyMeduim(errorMessage)),
        SizedBox(height: 10.h),
        InkWell(
          onTap: refreshCallback,
          child: const PaymentButton(
            icon: Icons.refresh,
            title: 'Try Again',
          ),
        )
      ],
    );
  }
}
