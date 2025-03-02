// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/presentation/screens/add-balance/add_balance_details_screen.dart';
import 'package:trading/features/balance/presentation/widgets/payments_methods_display.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class AddBalanceWidget extends StatefulWidget {
  const AddBalanceWidget({super.key, required this.paymentModel});
  final PaymentModel paymentModel;

  @override
  State<AddBalanceWidget> createState() => _AddBalanceWidgetState();
}

class _AddBalanceWidgetState extends State<AddBalanceWidget> {
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          // Navigator.of(context).pushNamed(AppRoutesNames.addBalanceDetails, arguments: {'imagePath': widget.imagePath});
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddBalanceDetailsScreen(paymentModel: widget.paymentModel),
            ),
          );
        },
        child: PaymentMethodDisplay(paymentModel: widget.paymentModel),
      );
    });
  }
}
