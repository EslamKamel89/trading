import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold_with_news_bar.dart';
import 'package:trading/core/presentation/no_internet.dart';
import 'package:trading/features/balance/presentation/blocs/withdraw_main_balance_cubit/withdraw_main_balance_cubit.dart';
import 'package:trading/features/balance/presentation/widgets/withdraw_from_main_balance_widget.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WithdrawMainBalanceScreen extends StatefulWidget {
  const WithdrawMainBalanceScreen({super.key});

  @override
  State<WithdrawMainBalanceScreen> createState() => _WithdrawMainBalanceScreenState();
}

class _WithdrawMainBalanceScreenState extends State<WithdrawMainBalanceScreen> {
  late final WithdrawMainBalanceCubit controller;

  @override
  void initState() {
    controller = context.read<WithdrawMainBalanceCubit>();
    // controller.getAllPaymentMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageController = context.read<PickLanguageAndThemeCubit>();
    controller.getAllPaymentMethod();
    return CustomScaffoldWithNewsBar(
      title: "WITHDRAW_FROM_MAIN_BALANCE".tr(context),
      child: BlocBuilder<WithdrawMainBalanceCubit, WithdrawMainBalanceState>(
        builder: (context, state) {
          if (state is WithdrawMainBalanceFailedState) {
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
          if (state is WithdrawMainBalanceLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WithdrawMainBalanceSuccessState) {
            return GridView.builder(
              itemCount: state.allPayments.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: (MediaQuery.of(context).size.width / 2) - 30.w,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.w,
              ),
              itemBuilder: (context, index) {
                // index++;
                return WithdrawFromMainBalanceWidget(paymentModel: state.allPayments[index]);
                // return _withdrawFromMainBalanceStaticData[index];
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

// List<Widget> _withdrawFromMainBalanceStaticData = [
//   const WithdrawFromMainBalanceWidget(imagePath: AppImages.vodafone),
//   const WithdrawFromMainBalanceWidget(imagePath: AppImages.fawry),
//   const WithdrawFromMainBalanceWidget(imagePath: AppImages.cib),
//   const WithdrawFromMainBalanceWidget(imagePath: AppImages.visa),
//   const WithdrawFromMainBalanceWidget(imagePath: AppImages.instapay),
// ];
