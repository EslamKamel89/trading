import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:trading/core/localization/localization.dart";
import "package:trading/core/text_styles/text_style.dart";
import "package:trading/core/themes/clr.dart";
import "package:trading/features/balance/domain/models/transaction_history_model.dart";
import "package:trading/features/balance/presentation/screens/transaction-history/deposit_history_details_screen.dart";
import "package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart";

class DepositHistoryWidget extends StatelessWidget {
  const DepositHistoryWidget({super.key, required this.depositHistoryList});
  final List<TransactionHistoryModel> depositHistoryList;

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: depositHistoryList.length,
      itemBuilder: (context, index) {
        final TransactionHistoryModel depositHistory = depositHistoryList[index];
        bool accepted, waiting, rejected = false;
        String requestState = "";
        Color requestColor = Clr.success;
        if (depositHistory.accepted == "1") {
          accepted = true;
          waiting = false;
          rejected = false;
          requestState = "ACCEPTED".tr(context);
          requestColor = Clr.success;
        } else {
          accepted = false;
          if (depositHistory.refuseReason != null) {
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
                  builder: (context) => DepositHistoryDetailsScreen(
                    depositHistory: depositHistory,
                    accepted: accepted,
                    waiting: waiting,
                    rejected: rejected,
                  ),
                ),
              );
            },
            title: Txt.bodyMeduim("${depositHistory.amount}\$"),
            subtitle: Txt.displayMeduim((depositHistory.createdAt ?? "").split(" ").first),
            trailing: Txt.bodyMeduim(requestState, color: requestColor),
          ),
        );
      },
    );
  }
}
