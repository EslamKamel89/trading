import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/routing/middleware.dart';
import 'package:trading/features/auth/presentation/screens/otp-forget/otp_forget.dart';
import 'package:trading/features/auth/presentation/screens/otp-signup/otp_signup.dart';
import 'package:trading/features/auth/presentation/screens/pick-verify-method-forget/pick_verify_method_forget.dart';
import 'package:trading/features/auth/presentation/screens/pick-verify-method-signup/pick_verify_method_signup_screen.dart';
import 'package:trading/features/auth/presentation/screens/reset-password-forget/reset_password_screen.dart';
import 'package:trading/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:trading/features/auth/presentation/screens/singin/signin_screen.dart';
import 'package:trading/features/auth/presentation/screens/tems-conditions/terms_conditons_screen.dart';
import 'package:trading/features/balance/presentation/blocs/transaction-history-cubit/transaction_history_cubit.dart';
import 'package:trading/features/balance/presentation/screens/add-balance/add_balance_screen.dart';
import 'package:trading/features/balance/presentation/screens/transaction-history/transaction_history_screen.dart';
import 'package:trading/features/balance/presentation/screens/withdraw-main-balance/withdraw_main_balance_screen.dart';
import 'package:trading/features/balance/presentation/screens/withdraw-weekly-balance/wihtdraw_weekly_balance_screen.dart';
import 'package:trading/features/mainpage/presentation/screens/bottom-navigation-screen/bottom_navigation_screen.dart';
import 'package:trading/features/notifications-news-certifications/presentation/screens/blog-news/blog_news_screen.dart';
import 'package:trading/features/notifications-news-certifications/presentation/screens/certifications/certifications_screen.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/screens/pick-language/pick_language.dart';
import 'package:trading/features/profile/presentation/screens/user_profile_screen.dart';
import 'package:trading/features/referrals/data/referals_repo_implement.dart';
import 'package:trading/features/referrals/presentation/blocs/add_refferals_cubit/add_referrals_cubit.dart';
import 'package:trading/features/referrals/presentation/screens/referrals-screen/referrals_screen.dart';
import 'package:trading/splash_screen/splash_screen.dart';
import 'package:trading/test.dart';
import 'package:trading/test1.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.pickLanguage:
        return MaterialPageRoute(
          builder: (context) => const PickLanguageScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.testScreen:
        return MaterialPageRoute(
          builder: (context) => const TestScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.testScreen1:
        return MaterialPageRoute(
          builder: (context) => const TestScreen1(),
          settings: routeSettings,
        );
      case AppRoutesNames.signup:
        return MaterialPageRoute(
          builder: (context) => const SingnupScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.termsAndConditions:
        return MaterialPageRoute(
          builder: (context) => const TermsAndConditonsScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.pickVerificationMethodSignup:
        return MaterialPageRoute(
          builder: (context) => const PickVerifyMehodSignupScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.otpSignup:
        return MaterialPageRoute(
          builder: (context) => const OtpSignupScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.signin:
        return MaterialPageRoute(
          builder: (context) => const SigninScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.pickVerificationMethodForget:
        return MaterialPageRoute(
          builder: (context) => PickVerifyMetodFroget(
            mobileOrEmailValue: (args as Map<String, String>)["mobileOrEmailValue"] ?? "",
          ),
          settings: routeSettings,
        );
      case AppRoutesNames.otpForget:
        return MaterialPageRoute(
          builder: (context) => const OtpForgetScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.resetPassword:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.bottomNavigationScreen:
        return MaterialPageRoute(
          builder: (context) => BottomNavigationScreen(
            args: args as Map?,
          ),
          settings: routeSettings,
        );
      case AppRoutesNames.addBalance:
        return MaterialPageRoute(
          builder: (context) => const AddBalanceScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.withdrawMainBalance:
        return MaterialPageRoute(
          builder: (context) => const WithdrawMainBalanceScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.withdrawWeeklyBalance:
        return MaterialPageRoute(
          builder: (context) => const WithdrawWeeklyBalanceScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.transactionHistory:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => TransactionHistoryCubit(paymentRepo: sl()),
            child: const TransactionHistoryScreen(),
          ),
          settings: routeSettings,
        );
      case AppRoutesNames.userProfile:
        return MaterialPageRoute(
          builder: (context) => const UserProfileScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.referrals:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AddReferralsCubit(refferalRepo: sl<ReferalsRepo>()),
            child: const ReferralsScreen(),
          ),
          settings: routeSettings,
        );
      case AppRoutesNames.certifications:
        return MaterialPageRoute(
          builder: (context) => const CertificationsScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.blogNews:
        return MaterialPageRoute(
          builder: (context) => const BlogNewsScreen(),
          settings: routeSettings,
        );
      // case AppRoutesNames.addBalanceDetails:
      //   return MaterialPageRoute(
      //     builder: (context) => AddBalanceDetailsScreen(
      //       args: args as Map,
      //     ),
      //     settings: routeSettings,
      //   );
      // case AppRoutesNames.withdrawMainBalanceDetails:
      //   return MaterialPageRoute(
      //     builder: (context) => const WithdrawMainBalanceDetailsScreen(),
      //     settings: routeSettings,
      //   );
      // case AppRoutesNames.withdrawWeeklyBalanceDetails:
      //   return MaterialPageRoute(
      //     builder: (context) => const WithdrawWeeklyBalanceDetailsScreen(),
      //     settings: routeSettings,
      //   );
      // case AppRoutesNames.welcome:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //       create: (context) => WelcomeBloc(),
      //       child: const WelcomeScreen(),
      //     ),
      //     settings: routeSettings,
      //   );

      default:
        return null;
    }
  }
}
