import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:trading/core/api/end_points.dart";
import "package:trading/core/localization/localization.dart";
import "package:trading/core/presentation/custom_scaffold.dart";
import "package:trading/core/text_styles/text_style.dart";
import "package:trading/core/themes/clr.dart";
import "package:trading/features/balance/domain/models/transaction_history_model.dart";
import "package:trading/features/balance/presentation/screens/transaction-history/widgets/deposit_history_details_info.dart";

class DepositHistoryDetailsScreen extends StatefulWidget {
  const DepositHistoryDetailsScreen({
    super.key,
    required this.depositHistory,
    this.accepted = false,
    this.waiting = false,
    this.rejected = false,
  });
  final TransactionHistoryModel depositHistory;
  final bool accepted, waiting, rejected;

  @override
  State<DepositHistoryDetailsScreen> createState() => _DepositHistoryDetailsScreenState();
}

class _DepositHistoryDetailsScreenState extends State<DepositHistoryDetailsScreen> {
  bool colapseContainer = true;
  bool showContent = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      colapseContainer = false;
      setState(() {});
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      showContent = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = Clr.success;
    String requestState = "";

    if (widget.accepted) {
      requestState = "ACCEPTED".tr(context);

      statusColor = colapseContainer ? Clr.success : Clr.success.withOpacity(0.1);
    } else if (widget.waiting) {
      requestState = "WAITING".tr(context);

      statusColor = colapseContainer ? Clr.warning : Clr.warning.withOpacity(0.1);
    } else if (widget.rejected) {
      requestState = "REJECTED".tr(context);

      statusColor = colapseContainer ? Clr.danger : Clr.danger.withOpacity(0.1);
    }
    // "${EndPoint.uploadUrl}${widget.depositHistory.imageOne}".prt("network Image");
    return CustomScaffold(
      title: "DEPOSIT_HISTORY_DETAILS".tr(context),
      showBackArrow: true,
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut,
        width: colapseContainer ? 1.w : 500.w,
        height: colapseContainer ? 1.w : 1000.h,
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: !showContent
            ? null
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DepositInfoDetails(widget: widget, requestState: requestState),
                    SizedBox(height: 10.h),
                    Divider(color: Clr.f),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w)),
                      child: Builder(
                        builder: (context) {
                          final image = Image.network(
                            "${EndPoint.uploadDepositHistory}${widget.depositHistory.imageOne}",
                            errorBuilder: (context, error, stackTrace) => Center(
                              child: Txt.bodyMeduim(
                                "DEPOSIT_DOCUMENTS_NOT_FOUND".tr(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            fit: BoxFit.fitHeight,
                          );
                          return image;
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Divider(color: Clr.f),
                    SizedBox(height: 10.h),
                    Txt.headlineMeduim("DEPOSIT_DATE".tr(context)),
                    Txt.bodyMeduim(widget.depositHistory.createdAt?.split(" ").first ?? "NOT_KNOWN".tr(context)),
                    SizedBox(height: 10.h),
                    Visibility(visible: widget.rejected, child: Divider(color: Clr.f)),
                    Visibility(visible: widget.rejected, child: SizedBox(height: 10.h)),
                    Visibility(visible: widget.rejected, child: Txt.headlineMeduim("REJECTION_REASON".tr(context))),
                    Visibility(
                        visible: widget.rejected,
                        child: Txt.bodyMeduim(widget.depositHistory.refuseReason ?? "NOT_KNOWN".tr(context))),
                  ],
                ),
              ),
      ),
    );
  }
}
