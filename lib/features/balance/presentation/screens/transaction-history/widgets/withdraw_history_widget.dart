import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:trading/core/localization/localization.dart";
import "package:trading/core/text_styles/text_style.dart";
import "package:trading/core/themes/clr.dart";
import "package:trading/features/balance/domain/models/withdraw_history_model.dart";
import "package:trading/features/balance/presentation/screens/transaction-history/withdraw_history_details_screen.dart";
import "package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart";

class WithdrawHistoryWidget extends StatelessWidget {
  const WithdrawHistoryWidget({super.key, required this.withdrawHistoryList});
  final List<WithdrawHistoryModel> withdrawHistoryList;

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: withdrawHistoryList.length,
      itemBuilder: (context, index) {
        final WithdrawHistoryModel witdrawHistory = withdrawHistoryList[index];
        bool accepted, waiting, rejected = false;
        String requestState = "";
        Color requestColor = Clr.success;
        if (witdrawHistory.accepted == "1") {
          accepted = true;
          waiting = false;
          rejected = false;
          requestState = "ACCEPTED".tr(context);
          requestColor = Clr.success;
        } else {
          accepted = false;
          if (witdrawHistory.refuseReason != null) {
            rejected = true;
            waiting = false;
            requestState = "REJECTED".tr(context);
            requestColor = Clr.danger;
          } else {
            rejected = false;
            waiting = true;
            requestState = "WAITING".tr(context);
            requestColor = Clr.warning;
          }
        }
        return Card(
          child: ListTile(
            onTap: () {
              // BlocProvider.value(value: sl<TransactionHistoryCubit>(), child: ,);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WithdrawHistoryDetailsScreen(
                    withdrawHistory: witdrawHistory,
                    accepted: accepted,
                    waiting: waiting,
                    rejected: rejected,
                  ),
                ),
              );
            },
            title: Txt.bodyMeduim("${witdrawHistory.amount}\$"),
            subtitle: Txt.displayMeduim((witdrawHistory.createdAt ?? "").split(" ").first),
            trailing: Txt.bodyMeduim(requestState, color: requestColor),
          ),
        );
      },
    );
  }
}
