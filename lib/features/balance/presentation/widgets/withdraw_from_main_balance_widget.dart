// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/presentation/screens/withdraw-main-balance/withdraw_main_balance_details_screen.dart';
import 'package:trading/features/balance/presentation/widgets/payments_methods_display.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WithdrawFromMainBalanceWidget extends StatelessWidget {
  const WithdrawFromMainBalanceWidget({super.key, required this.paymentModel});
  final PaymentModel paymentModel;

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => WithdrawMainBalanceDetailsScreen(
              paymentModel: paymentModel,
            ),
          ),
        );
      },
      child: PaymentMethodDisplay(paymentModel: paymentModel),
    );
  }
}
