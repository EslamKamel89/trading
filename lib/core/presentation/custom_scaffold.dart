import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/body-widget/body_widget.dart';
import 'package:trading/core/presentation/app_drawer.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/mainpage/presentation/widgets/main_appbar.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.title,
    required this.child,
    this.showBackArrow = false,
    this.bottom,
    this.scaffoldKey,
    this.showHomeIcon = true,
  });
  final String title;
  final Widget child;
  final bool showBackArrow;
  final PreferredSizeWidget? bottom;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool showHomeIcon;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PickLanguageAndThemeCubit>();
    return Scaffold(
      appBar: mainAppBar(title: title, context: context, showBackArrow: showBackArrow, bottom: bottom),
      key: scaffoldKey,
      endDrawer: const AppDrawer(),
      floatingActionButton: showHomeIcon
          ? FloatingActionButton(
              backgroundColor: Clr.d,
              elevation: 5,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutesNames.bottomNavigationScreen,
                  (route) => false,
                  arguments: {'index': 1},
                );
              },
              child: const Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
            )
          : null,
      body: BodyWidget(
        child: child,
      ),
    );
  }
}
