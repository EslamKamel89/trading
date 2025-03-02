import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold_with_news_bar.dart';
import 'package:trading/core/presentation/no_internet.dart';
import 'package:trading/features/balance/presentation/blocs/add_balance_cubit/add_balance_cubit.dart';
import 'package:trading/features/balance/presentation/widgets/add_to_balance.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({super.key});

  @override
  State<AddBalanceScreen> createState() => _AddBalanceScreenState();
}

class _AddBalanceScreenState extends State<AddBalanceScreen> {
  late final AddBalanceCubit controller;
  @override
  void initState() {
    controller = context.read<AddBalanceCubit>();
    controller.getAllPaymentMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageController = context.read<PickLanguageAndThemeCubit>();
    controller.getAllPaymentMethod();
    return CustomScaffoldWithNewsBar(
      title: "ADD_TO_BALANCE".tr(context),
      child: BlocConsumer<AddBalanceCubit, AddBalanceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AddBalanceFailedState) {
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
          if (state is AddBalanceLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AddBalanceGetPaymentSuccessState) {
            return GridView.builder(
              itemCount: state.allPayments.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: (MediaQuery.of(context).size.width / 2) - 30.w,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.w,
              ),
              itemBuilder: (context, index) {
                // if (index == 0) {
                //   return InkWell(
                //     onTap: () {
                //       Navigator.of(context)
                //           .push(MaterialPageRoute(builder: (_) => const TransformProfitBalanceScreen()));
                //     },
                //     child: PaymentMethodDisplay(
                //       paymentModel: PaymentModel(name: "PROFIT_BALANCE".tr(context)),
                //       transformProfitBalance: true,
                //     ),
                //   );
                // }
                // index--;
                return AddBalanceWidget(paymentModel: state.allPayments[index]);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
