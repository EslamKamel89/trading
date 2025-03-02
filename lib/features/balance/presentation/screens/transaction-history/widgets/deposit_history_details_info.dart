import 'package:flutter/material.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/balance/presentation/screens/transaction-history/deposit_history_details_screen.dart';

class DepositInfoDetails extends StatelessWidget {
  const DepositInfoDetails({
    super.key,
    required this.widget,
    required this.requestState,
  });

  final DepositHistoryDetailsScreen widget;
  final String requestState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Txt.bodyMeduim('DEPOSIT_AMOUNT'.tr(context)),
            Txt.headlineMeduim('${widget.depositHistory.amount}\$'),
          ],
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Txt.bodyMeduim('DEPOSIT_STATE'.tr(context)),
            Txt.headlineMeduim(requestState),
          ],
        ),
      ],
    );
  }
}
