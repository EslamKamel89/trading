import 'package:flutter/material.dart';
import 'package:trading/core/text_styles/text_style.dart';

customSnackBar({
  required BuildContext context,
  required String title,
  bool isSuccess = true,
  int? durationSeconds,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Txt.bodyMeduim(
        title,
        color: Colors.white,
      ),
      backgroundColor: isSuccess ? const Color(0xff1A4D2E).withOpacity(0.3) : const Color(0xffC40C0C).withOpacity(0.3),
      duration: Duration(seconds: durationSeconds ?? 2),
    ),
  );
}
