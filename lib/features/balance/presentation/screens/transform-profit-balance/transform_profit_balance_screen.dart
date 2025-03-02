import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/balance/presentation/blocs/add_balance_cubit/add_balance_cubit.dart';
import 'package:trading/features/balance/presentation/widgets/payment_text_field.dart';
import 'package:trading/features/balance/presentation/widgets/paymet_button.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class TransformProfitBalanceScreen extends StatefulWidget {
  const TransformProfitBalanceScreen({super.key});

  @override
  State<TransformProfitBalanceScreen> createState() => _TransformProfitBalanceScreenState();
}

class _TransformProfitBalanceScreenState extends State<TransformProfitBalanceScreen> {
  late final AddBalanceCubit addBalanceCubit;
  // TextEditingController? accountNumberController;
  TextEditingController? transformAmountController;
  @override
  void initState() {
    addBalanceCubit = context.read<AddBalanceCubit>();
    // accountNumberController = TextEditingController();
    transformAmountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // accountNumberController = TextEditingController();
    transformAmountController = TextEditingController();
    addBalanceCubit.getAllPaymentMethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return CustomScaffold(
      showBackArrow: true,
      title: "FROM_PROFIT_BALANCE".tr(context),
      child: BlocConsumer<AddBalanceCubit, AddBalanceState>(
        listener: (context, state) {
          if (state is AddBalanceFromProfitFailedState) {
            customSnackBar(context: context, title: state.errorMessage, isSuccess: false);
            Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.bottomNavigationScreen, (route) => true);
          }
          if (state is AddBalanceFromProfitSuccessState) {
            customSnackBar(context: context, title: 'Withdraw Process Completed Successfuly');
            Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.bottomNavigationScreen, (route) => true);
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              const TransformProfitBalancePhoto(),
              SizedBox(height: 20.h),
              Center(
                child: PaymentTextField(
                  hintText: "TRANSFER_AMOUNT".tr(context),
                  fieldType: "number",
                  controller: transformAmountController,
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: Builder(builder: (context) {
                  if (state is AddBalanceFromProfitLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return InkWell(
                    onTap: () async {
                      await addBalanceCubit.withdrawProfitBalance(
                        paymentId: 2,
                        accountNumber: "moneymaker",
                        amount: double.parse(transformAmountController!.text),
                      );
                    },
                    child: PaymentButton(title: "SUBMIT".tr(context), icon: Icons.login),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TransformProfitBalancePhoto extends StatelessWidget {
  const TransformProfitBalancePhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final languageController = context.watch<PickLanguageAndThemeCubit>();
    return Material(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            boxShadow: [
              BoxShadow(
                offset: Offset(5.w, 5.w),
                blurRadius: 10,
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: languageController.isEnglishLanguage()
              ? Image.asset(
                  AppImages.transformProfitBlanace,
                  // width: ,
                  height: 300.h,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  AppImages.transformProfitBlanaceAr,
                  // width: ,
                  height: 300.h,
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}
