import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/body-widget/body_widget.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_drawer.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Screen...."),
      ),
      endDrawer: const AuthDrawer(),
      body: BodyWidget(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt.bodyMeduim("Light Theme"),
                Txt.bodyMeduim("Dark Theme"),
              ],
            ),
            ColoredContainerTest(color1: Clr.aLight, color2: Clr.aDark),
            ColoredContainerTest(color1: Clr.bLight, color2: Clr.bDark),
            ColoredContainerTest(color1: Clr.cLight, color2: Clr.cDark),
            ColoredContainerTest(color1: Clr.dLight, color2: Clr.dDark),
            ColoredContainerTest(color1: Clr.eLight, color2: Clr.eDark),
            ColoredContainerTest(color1: Clr.fLight, color2: Clr.fDark),
          ],
        ),
      ),
    );
  }
}

class ColoredContainerTest extends StatelessWidget {
  const ColoredContainerTest({
    super.key,
    required this.color1,
    required this.color2,
  });
  final Color color1;
  final Color color2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            height: 100.h,
            color: color1,
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Container(
            height: 100.h,
            color: color2,
          ),
        ),
      ],
    );
  }
}
