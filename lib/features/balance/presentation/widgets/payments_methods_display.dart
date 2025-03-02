import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/presentation/custom_image.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class PaymentMethodDisplay extends StatelessWidget {
  const PaymentMethodDisplay({
    super.key,
    required this.paymentModel,
    this.transformProfitBalance = false,
  });

  final PaymentModel paymentModel;
  final bool transformProfitBalance;

  @override
  Widget build(BuildContext context) {
    final languageController = context.read<PickLanguageAndThemeCubit>();
    return Material(
      // shape: const CircleBorder(),
      elevation: 5,
      borderRadius: BorderRadius.circular(20.w),
      color: Clr.d,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              // padding: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: Colors.red,
              ),
              clipBehavior: Clip.hardEdge,
              child: transformProfitBalance
                  ? languageController.isEnglishLanguage()
                      ? Image.asset(
                          AppImages.transformProfitBlanace,
                          // width: ,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          AppImages.transformProfitBlanaceAr,
                          // width: ,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                  :
                  // Image.network(
                  //     EndPoint.uploadPayment + (paymentModel.image ?? ''),
                  //     errorBuilder: (context, error, stackTrace) {
                  //       return Txt.bodyMeduim('Image Not Found');
                  //     },
                  //     width: double.infinity,
                  //     height: double.infinity,
                  //     fit: BoxFit.cover,
                  //   )
                  CustomRectangleImage(
                      networkImagePath: EndPoint.uploadPayment + (paymentModel.image ?? ''),
                      placeholderAssetPath: AppImages.moneyMaker,
                      height: double.infinity,
                      width: double.infinity,
                    ),
            ),
          ),
          Txt.bodyMeduim(paymentModel.name ?? 'Unknown', textAlign: TextAlign.center, color: Colors.white),
        ],
      ),
    );
  }
}
