import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold_with_news_bar.dart';
import 'package:trading/core/presentation/no_internet.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/presentation/blocs/withdraw_weekly_balance_cubit/withdraw_weekly_balance_cubit.dart';
import 'package:trading/features/balance/presentation/screens/transform-profit-balance/transform_profit_balance_screen.dart';
import 'package:trading/features/balance/presentation/widgets/payments_methods_display.dart';
import 'package:trading/features/balance/presentation/widgets/withdraw_from_weekly_balance_widget.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WithdrawWeeklyBalanceScreen extends StatelessWidget {
  const WithdrawWeeklyBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<WithdrawWeeklyBalanceCubit>();
    final languageController = context.read<PickLanguageAndThemeCubit>();
    controller.getAllPaymentMethod();
    return CustomScaffoldWithNewsBar(
      title: "WITHDRAW_FROM_WEEKLY_BALANCE".tr(context),
      child: BlocConsumer<WithdrawWeeklyBalanceCubit, WithdrawWeeklyBalanceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is WithdrawWeeklyBalanceFailedState) {
            final String errorMessage;
            if (languageController.isEnglishLanguage()) {
              errorMessage = state.errorModel.errorMessageEn ?? 'Error';
            } else {
              errorMessage = state.errorModel.errorMessageAr ?? 'خطأ';
            }
            return NoInternetWidget(
              errorMessage: errorMessage,
              refreshCallback: () {
                controller.getAllPaymentMethod();
              },
            );
          }
          if (state is WithdrawWeeklyBalanceLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WithdrawWeeklyBalanceSuccessState) {
            return GridView.builder(
              itemCount: state.allPayments.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: (MediaQuery.of(context).size.width / 2) - 30.w,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.w,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const TransformProfitBalanceScreen()));
                    },
                    child: PaymentMethodDisplay(
                      paymentModel: PaymentModel(name: "PROFIT_BALANCE".tr(context)),
                      transformProfitBalance: true,
                    ),
                  );
                }
                index--;
                return WithdrawFromWeeklyBalanceWidget(paymentModel: state.allPayments[index]);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

// List<Widget> _withdrawFromWeeklyBalanceStaticData = [
//   WithdrawFromMainBalanceWidget(imagePath: AppImages.vodafone),
//   WithdrawFromMainBalanceWidget(imagePath: AppImages.fawry),
//   WithdrawFromMainBalanceWidget(imagePath: AppImages.cib),
//   WithdrawFromMainBalanceWidget(imagePath: AppImages.visa),
//   WithdrawFromMainBalanceWidget(imagePath: AppImages.instapay),
// ];
