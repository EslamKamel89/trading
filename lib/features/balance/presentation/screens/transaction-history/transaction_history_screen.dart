import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/balance/presentation/blocs/transaction-history-cubit/transaction_history_cubit.dart';
import 'package:trading/features/balance/presentation/screens/transaction-history/widgets/depoist_history_widget.dart';
import 'package:trading/features/balance/presentation/screens/transaction-history/widgets/withdraw_history_widget.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late TransactionHistoryCubit controller;
  @override
  void initState() {
    controller = context.read<TransactionHistoryCubit>();
    controller.getDepositHistory();
    controller.getWithdrawHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(seconds: 1),
      initialIndex: 0,
      child: CustomScaffold(
        title: "TRNASACTIONS".tr(context),
        bottom: TabBar(
          dividerColor: Clr.f,
          indicatorColor: Clr.f,
          labelColor: Clr.f,
          unselectedLabelColor: Clr.b,
          indicatorWeight: 5,
          onTap: (value) {},
          tabs: [
            Tab(
              text: "WITHDRAW_HISTORY".tr(context),
              icon: const Icon(Icons.history),
            ),
            Tab(
              text: "DEPOSIT_HISTORY".tr(context),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        child: BlocListener<TransactionHistoryCubit, TransactionHistoryState>(
            listener: (context, state) {
              if (state is TransactionHistorySuccessState) {
                state.allDepositHistory.prm('Fetched Deposit History Data');
              }
              if (state is TransactionHistoryFailedState) {
                customSnackBar(context: context, title: state.errorModel.errorMessageEn ?? 'Error', isSuccess: false);
              }
              if (state is WithdrawHistorySuccessState) {
                state.allWithdrawHistory.prm('Fetched Deposit History Data');
              }
              if (state is WithdrawHistoryFailedState) {
                customSnackBar(context: context, title: state.errorModel.errorMessageEn ?? 'Error', isSuccess: false);
              }
            },
            child: TabBarView(
              children: [
                Builder(builder: (context) {
                  //  controller.getDepositHistory();
                  controller.getWithdrawHistory();
                  return BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
                    buildWhen: (previous, current) {
                      if (current is WithdrawHistoryLoadingState || current is WithdrawHistorySuccessState) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      if (state is WithdrawHistoryLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is WithdrawHistorySuccessState) {
                        if (state.allWithdrawHistory.isEmpty) {
                          return Center(child: Txt.bodyMeduim("NO_DATA_WITHDRAW_HISTORY".tr(context)));
                        } else {
                          return WithdrawHistoryWidget(withdrawHistoryList: state.allWithdrawHistory);
                        }
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                }),
                Builder(builder: (context) {
                  controller.getDepositHistory();
                  // controller.getWithdrawHistory();
                  return BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
                    buildWhen: (previous, current) {
                      if (current is TransactionHistoryLoadingState || current is TransactionHistorySuccessState) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      if (state is TransactionHistoryLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is TransactionHistorySuccessState) {
                        if (state.allDepositHistory.isEmpty) {
                          return Center(child: Txt.bodyMeduim("NO_DATA_DEPOSIT_HISTORY".tr(context)));
                        } else {
                          return DepositHistoryWidget(depositHistoryList: state.allDepositHistory);
                        }
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                }),
              ],
            )),
      ),
    );
  }
}
