import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/firebase_notification/firebase_notification.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/routing/app_router.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';
import 'package:trading/features/balance/data/payment_repo_imp.dart';
import 'package:trading/features/balance/presentation/blocs/add_balance_cubit/add_balance_cubit.dart';
import 'package:trading/features/balance/presentation/blocs/withdraw_main_balance_cubit/withdraw_main_balance_cubit.dart';
import 'package:trading/features/balance/presentation/blocs/withdraw_weekly_balance_cubit/withdraw_weekly_balance_cubit.dart';
import 'package:trading/features/chat/data/chat_repo_implement.dart';
import 'package:trading/features/chat/presentation/blocs/chat-cubit/chat_cubit.dart';
import 'package:trading/features/notifications-news-certifications/data/news_repo_implement.dart';
import 'package:trading/features/notifications-news-certifications/presentation/blocs/news-cubit/news_cubit.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/support/data/support_repo_implement.dart';
import 'package:trading/features/support/presentation/blocs/support-cubit/support_cubit.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(FirebaseHelper.firebaseMessagingBackgroundHandler);
  // runApp(DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) {
  //       return const MyApp();
  //     }));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseHelper.getToken();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<PickLanguageAndThemeCubit>(
              create: (context) => sl<PickLanguageAndThemeCubit>()
                ..checkCachedLanguage()
                ..checkCachedTheme(),
            ),
            BlocProvider<SignupCubit>(create: (context) => SignupCubit(authRepo: sl<AuthRepo>())),
            BlocProvider<SigninCubit>(create: (context) => SigninCubit(authRepo: sl<AuthRepo>())),
            BlocProvider<ChatCubit>(create: (context) => ChatCubit(chatRepo: sl<ChatRepo>())),
            BlocProvider<AddBalanceCubit>(create: (context) => AddBalanceCubit(paymentRepo: sl<PaymentRepo>())),
            BlocProvider<NewsCubit>(create: (context) => NewsCubit(newsRepo: sl<NewsRepo>())),
            BlocProvider<SupportCubit>(create: (context) => SupportCubit(supportRepo: sl<SupportRepo>())),
            BlocProvider<WithdrawMainBalanceCubit>(
                create: (context) => WithdrawMainBalanceCubit(paymentRepo: sl<PaymentRepo>())),
            BlocProvider<WithdrawWeeklyBalanceCubit>(
                create: (context) => WithdrawWeeklyBalanceCubit(paymentRepo: sl<PaymentRepo>())),
          ],
          child: Builder(builder: (context) {
            final PickLanguageAndThemeCubit pickLanguageCubit = context.watch<PickLanguageAndThemeCubit>();
            // pickLanguageCubit.checkCachedTheme();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: pickLanguageCubit.state.themeData,
              initialRoute: AppRoutesNames.splashScreen,
              // initialRoute: AppRoutesNames.transactionHistory,
              onGenerateRoute: sl<AppRouter>().onGenerateRoute,
              locale: pickLanguageCubit.state.locale,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalization.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                bool languageSupported = false;
                for (var locale in supportedLocales) {
                  if (deviceLocale?.languageCode == locale.languageCode) {
                    languageSupported = true;
                  }
                }
                if (deviceLocale != null && languageSupported) {
                  return deviceLocale;
                }
                return supportedLocales.first;
              },
            );
          }),
        );
      },
    );
  }
}
