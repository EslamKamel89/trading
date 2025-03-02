import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class PaymentTextField extends StatelessWidget {
  const PaymentTextField({
    super.key,
    this.hintText,
    this.controller,
    this.fieldType,
    this.validator,
  });
  final String? hintText;
  final TextEditingController? controller;
  final String? fieldType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return Builder(builder: (context) {
      final InputBorder border = UnderlineInputBorder(
        borderSide: BorderSide(
          color: Clr.iconGoldColor,
        ),
      );
      return TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          hintText: hintText,
          hintStyle: TextStyle(
              color: themeController.isLightTheme() ? Clr.bDark.withOpacity(0.5) : Clr.bLight, fontSize: 12.sp),
        ),
        keyboardType: _keyboardType(fieldType),
      );
    });
  }

  TextInputType? _keyboardType(String? fieldType) {
    if (fieldType == 'date') {
      return TextInputType.datetime;
    }
    if (fieldType == 'number') {
      return const TextInputType.numberWithOptions(signed: false);
    }
    return null;
  }
}
