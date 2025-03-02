import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class PasswordTextFieldUserProfile extends StatefulWidget {
  const PasswordTextFieldUserProfile({
    super.key,
    this.hintText,
    this.controller,
  });
  final String? hintText;
  final TextEditingController? controller;

  @override
  State<PasswordTextFieldUserProfile> createState() => _PasswordTextFieldUserProfileState();
}

class _PasswordTextFieldUserProfileState extends State<PasswordTextFieldUserProfile> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return Builder(builder: (context) {
      final InputBorder border = UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).dividerColor, style: BorderStyle.solid),
      );
      return TextFormField(
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Clr.f, fontSize: 12.sp),
          suffixIcon: InkWell(
            onTap: () {
              showPassword = !showPassword;
              setState(() {});
            },
            child: Icon(_getIcon(), size: 20.w, color: Clr.f),
          ),
        ),
        obscureText: !showPassword,
      );
    });
  }

  IconData _getIcon() {
    if (showPassword) {
      return Icons.remove_red_eye_sharp;
    } else {
      return Icons.visibility_off_outlined;
    }
  }
}
