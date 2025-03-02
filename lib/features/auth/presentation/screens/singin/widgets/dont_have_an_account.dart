import 'package:flutter/material.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Txt.bodyMeduim(
            "DONT_HAVE_ACCOUNT".tr(context),
            color: const Color(0xff939393),
            fontWeight: FontWeight.bold,
          ),
          GestureDetector(
            onTap: () => {Navigator.pushNamed(context, AppRoutesNames.signup)},
            child: Txt.bodyMeduim(
              "SIGNUP".tr(context),
              color: const Color(0xff748288),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
