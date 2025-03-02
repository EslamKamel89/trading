import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/firebase_notification/firebase_notification.dart';
import 'package:trading/core/functions/format_currency.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/app_drawer.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/mainpage/data/advertise_repo_implement.dart';
import 'package:trading/features/mainpage/presentation/blocs/mainpage_cubit/mainpage_cubit.dart';
import 'package:trading/features/mainpage/presentation/screens/homepage-screen/functions/show_graph_ratio.dart';
import 'package:trading/features/mainpage/presentation/screens/homepage-screen/widgets/custom_mainpage_chart.dart';
import 'package:trading/features/mainpage/presentation/screens/homepage-screen/widgets/mainpage_navigation_button.dart';
import 'package:trading/features/mainpage/presentation/widgets/custom_image_slider.dart';
import 'package:trading/features/mainpage/presentation/widgets/main_appbar.dart';
import 'package:trading/features/notifications-news-certifications/presentation/blocs/news-cubit/news_cubit.dart';
import 'package:trading/features/notifications-news-certifications/presentation/widgets/news_widget.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    FirebaseHelper.requestPermisson(context).then((value) => FirebaseHelper.getToken());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeCont = context.watch<PickLanguageAndThemeCubit>();
    final newsCubit = context.read<NewsCubit>()..getNewsArray();
    Clr.init();
    return BlocProvider(
      create: (context) => MainpageCubit(
        advertiseRepo: sl<AdvertiseRepo>(),
        // authRepo: sl<AuthRepo>(),
      )
        ..getAdvertise()
        ..getUserData(),
      child: Builder(
        builder: (context) {
          final controller = context.read<MainpageCubit>();
          controller.refreshUserData();
          // controller.getUserData();
          // controller.getAdvertise();
          return Scaffold(
            appBar: mainAppBar(title: '', context: context),
            key: scaffoldKey,
            endDrawer: const AppDrawer(),
            // backgroundColor: Colors.transparent,
            body: SafeArea(
              child: BlocBuilder<MainpageCubit, MainpageState>(
                buildWhen: (previous, current) {
                  return false;
                },
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await controller.getUserData();
                      await controller.getAdvertise();
                      await newsCubit.getNewsArray();
                      controller.refreshUserData();
                    },
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 550.h,
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: BlocBuilder<MainpageCubit, MainpageState>(
                                  builder: (context, state) {
                                    return const NewsWiget(showNews: true);
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              BlocBuilder<MainpageCubit, MainpageState>(
                                buildWhen: (previous, current) {
                                  if (current is AdvertiseSuccessState) {
                                    return true;
                                  } else {
                                    return false;
                                  }
                                },
                                builder: (context, state) {
                                  return const CustomImageSlider();
                                },
                              ),
                              SizedBox(height: 10.h),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: BlocBuilder<MainpageCubit, MainpageState>(
                                    buildWhen: (previous, current) {
                                      if (current is MainpageSuccessState) {
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    },
                                    builder: (context, state) {
                                      return MainpageChart(
                                        borderColor: Theme.of(context).scaffoldBackgroundColor,
                                        mainColor: Theme.of(context).scaffoldBackgroundColor,
                                        sectionColor: themeCont.isLightTheme()
                                            ? const Color(0xFFE4C59E)
                                            : const Color(0xFF322C2B),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class MainpageChart extends StatefulWidget {
  const MainpageChart({
    super.key,
    required this.mainColor,
    required this.borderColor,
    required this.sectionColor,
  });
  final Color mainColor;
  final Color borderColor;
  final Color sectionColor;

  @override
  State<MainpageChart> createState() => _MainpageChartState();
}

class _MainpageChartState extends State<MainpageChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MainpageCubit>();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.sectionColor,
              borderRadius: BorderRadius.circular(50.w),
              border: Border.all(
                width: 10.w,
                color: widget.borderColor,
              ),
            ),
          ),
          Positioned(
            top: 30.w,
            left: 30.w,
            child: MainpageNavigationButton(
              color: widget.borderColor,
              routeName: AppRoutesNames.withdrawWeeklyBalance,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Txt.bodyMeduim("WEEKLY_PROFIT".tr(context)),
                  Txt.displayMeduim(
                    formatCurrency(controller.userModel?.weekly),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30.w,
            right: 30.w,
            child: MainpageNavigationButton(
              color: widget.borderColor,
              routeName: AppRoutesNames.withdrawMainBalance,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Txt.bodyMeduim("ACCOUNT".tr(context)),
                  Txt.displayMeduim(formatCurrency(controller.userModel?.balance)
                      // '\$15482.2',
                      ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30.w,
            left: 30.w,
            child: Container(
              color: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Txt.displayMeduim(
                      formatCurrency(controller.userModel?.daily),
                      // '\$15482.2',
                    ),
                    Txt.bodyMeduim("DAILY_PROFIT".tr(context)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30.w,
            right: 30.w,
            child: Container(
              color: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Txt.displayMeduim(formatCurrency(controller.userModel?.referral)
                        // '\$15482.2',
                        ),
                    Txt.bodyMeduim("REFERELS".tr(context)),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: 10.w,
                  height: constraints.maxHeight,
                  color: widget.borderColor,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 10.w,
                  width: constraints.maxWidth,
                  color: widget.borderColor,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                height: 250.w,
                width: 250.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.mainColor,
                  border: Border.all(
                    width: 10.w,
                    color: widget.borderColor,
                  ),
                ),
                child: CustomMainpageChart(
                  sectionColor: widget.sectionColor,
                  dailyProfitPercent: showGraphRatio(
                    numerator: controller.userModel?.daily,
                    denominator: controller.userModel?.balance,
                  ),
                  referallProfitPercent: showGraphRatio(
                    numerator: controller.userModel?.referral,
                    denominator: controller.userModel?.balance,
                  ),
                  profitDollar: 1200,
                )),
          )
        ],
      ),
    );
  }
}
