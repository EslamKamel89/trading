import 'package:flutter/material.dart';
import 'package:trading/core/text_styles/text_style.dart';

AppBar authAppBar({
  required String title,
  required BuildContext context,
  bool automaticallyImplyLeading = true,
}) {
  return AppBar(
    // title: Txt.headlineMeduim(title),
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: automaticallyImplyLeading,
  );
}

AppBar termsAndConditionsAppBar({
  required String title,
  required BuildContext context,
  bool automaticallyImplyLeading = true,
}) {
  return AppBar(
    title: Txt.headlineMeduim(title),
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: automaticallyImplyLeading,
  );
}
