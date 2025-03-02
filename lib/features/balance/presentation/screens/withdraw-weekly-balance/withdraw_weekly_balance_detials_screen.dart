import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_image.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/presentation/blocs/withdraw_weekly_balance_cubit/withdraw_weekly_balance_cubit.dart';
import 'package:trading/features/balance/presentation/widgets/payment_text_field.dart';
import 'package:trading/features/balance/presentation/widgets/paymet_button.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WithdrawWeeklyBalanceDetailsScreen extends StatefulWidget {
  const WithdrawWeeklyBalanceDetailsScreen({super.key, required this.paymentModel});
  final PaymentModel paymentModel;

  @override
  State<WithdrawWeeklyBalanceDetailsScreen> createState() => _WithdrawWeeklyBalanceDetailsScreenState();
}

class _WithdrawWeeklyBalanceDetailsScreenState extends State<WithdrawWeeklyBalanceDetailsScreen> {
  late final WithdrawWeeklyBalanceCubit withdrawWeeklyBalanceController;
  TextEditingController? accountNumberController;
  TextEditingController? withdrawAmountController;
  @override
  void initState() {
    withdrawWeeklyBalanceController = context.read<WithdrawWeeklyBalanceCubit>();
    accountNumberController = TextEditingController();
    withdrawAmountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    accountNumberController = TextEditingController();
    withdrawAmountController = TextEditingController();
    withdrawWeeklyBalanceController.getAllPaymentMethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return BlocListener<WithdrawWeeklyBalanceCubit, WithdrawWeeklyBalanceState>(
      listener: (context, state) {
        if (state is WithdrawWeeklyRequestFailedState) {
          customSnackBar(context: context, title: state.errorMessage, isSuccess: false);
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.bottomNavigationScreen, (route) => true);
        }
        if (state is WithdrawWeeklyRequestSuccessState) {
          customSnackBar(context: context, title: 'Withdraw Process Completed Successfuly');
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.bottomNavigationScreen, (route) => true);
        }
      },
      child: CustomScaffold(
        showBackArrow: true,
        title: "WITHDRAW_FROM_WEEKLY_BALANCE".tr(context),
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          children: [
            // Center(
            //   child: CircleAvatar(
            //     backgroundImage: NetworkImage(EndPoint.uploadPayment + (widget.paymentModel.image ?? '')),
            //     maxRadius: 100.w,
            //   ),
            // ),
            CustomCircularImage(
              placeholderAssetPath: AppImages.moneymakerLogo,
              networkImagePath: EndPoint.uploadPayment + (widget.paymentModel.image ?? ''),
              size: 200.w,
              margin: null,
            ),
            SizedBox(height: 20.h),
            PaymentTextField(
              hintText: "TRANSACTION_NUMBER".tr(context),
              controller: accountNumberController,
            ),
            SizedBox(height: 20.h),
            PaymentTextField(
              hintText: "TRANSACTION_AMOUNT".tr(context),
              fieldType: 'number',
              controller: withdrawAmountController,
            ),
            SizedBox(height: 40.h),
            SizedBox(height: 20.h),
            Center(
              child: BlocBuilder<WithdrawWeeklyBalanceCubit, WithdrawWeeklyBalanceState>(
                builder: (context, state) {
                  if (state is WithdrawWeeklyRequestLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return InkWell(
                    onTap: () async {
                      await withdrawWeeklyBalanceController.withdraw(
                        paymentId: widget.paymentModel.id!,
                        accountNumber: accountNumberController!.text,
                        amount: double.parse(withdrawAmountController!.text),
                      );
                    },
                    child: PaymentButton(title: "SUBMIT".tr(context), icon: Icons.login),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
