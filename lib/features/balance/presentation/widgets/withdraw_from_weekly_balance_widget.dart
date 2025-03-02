// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/presentation/screens/withdraw-weekly-balance/withdraw_weekly_balance_detials_screen.dart';
import 'package:trading/features/balance/presentation/widgets/payments_methods_display.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WithdrawFromWeeklyBalanceWidget extends StatelessWidget {
  const WithdrawFromWeeklyBalanceWidget({super.key, required this.paymentModel});
  final PaymentModel paymentModel;

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => WithdrawWeeklyBalanceDetailsScreen(
              paymentModel: paymentModel,
            ),
          ),
        );
      },
      child: PaymentMethodDisplay(paymentModel: paymentModel),
    );
  }
}
