import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/add_referrals_screen.dart';
import 'package:trading/features/referrals/presentation/screens/referals-history/referals_history_screen.dart';

class ReferralsScreen extends StatefulWidget {
  const ReferralsScreen({super.key});

  @override
  State<ReferralsScreen> createState() => _ReferralsScreenState();
}

class _ReferralsScreenState extends State<ReferralsScreen> {
  late final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  void initState() {
    scaffoldKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(seconds: 1),
      initialIndex: 0,
      child: CustomScaffold(
        title: "REFERRALS".tr(context),
        scaffoldKey: scaffoldKey,
        // showHomeIcon: false,
        bottom: TabBar(
          dividerColor: Clr.f,
          indicatorColor: Clr.f,
          labelColor: Clr.f,
          unselectedLabelColor: Clr.b,
          indicatorWeight: 5,
          tabs: [
            Tab(
              icon: const Icon(Icons.history),
              child: Txt.bodyMeduim("YOUR_REFERRAL".tr(context)),
            ),
            Tab(
              icon: const Icon(Icons.add),
              child: Txt.bodyMeduim("ADD_REFERRAL".tr(context)),
            ),
          ],
        ),
        child: TabBarView(
          children: [
            const ReferalsHistoryScreen(),
            AddReferralsScreen(scaffoldKey: scaffoldKey),
          ],
        ),
      ),
    );
  }
}
