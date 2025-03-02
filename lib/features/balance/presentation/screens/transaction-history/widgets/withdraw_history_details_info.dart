import "package:flutter/material.dart";
import "package:trading/core/localization/localization.dart";
import "package:trading/core/text_styles/text_style.dart";
import "package:trading/features/balance/domain/models/withdraw_history_model.dart";

class WithdrawInfoDetails extends StatelessWidget {
  const WithdrawInfoDetails({
    super.key,
    required this.withdrawHistoryModel,
    required this.requestState,
  });

  final WithdrawHistoryModel withdrawHistoryModel;
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
            Txt.bodyMeduim("WITHDRAW_AMOUNT".tr(context)),
            Txt.headlineMeduim("${withdrawHistoryModel.amount}\$"),
          ],
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Txt.bodyMeduim("WITHDRAW_STATE".tr(context)),
            Txt.headlineMeduim(requestState),
          ],
        ),
      ],
    );
  }
}
