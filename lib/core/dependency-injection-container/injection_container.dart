import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/dio_consumer.dart';
import 'package:trading/core/localization/locale_cache_helper.dart';
import 'package:trading/core/routing/app_router.dart';
import 'package:trading/core/routing/middleware.dart';
import 'package:trading/core/themes/theme_cache_helper.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/balance/data/payment_repo_imp.dart';
import 'package:trading/features/chat/data/chat_repo_implement.dart';
import 'package:trading/features/mainpage/data/advertise_repo_implement.dart';
import 'package:trading/features/notifications-news-certifications/data/news_repo_implement.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/referrals/data/referals_repo_implement.dart';
import 'package:trading/features/support/data/support_repo_implement.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! -- External --------------------------------------------------------------------------------------------------------------
  //? sharedPreferences ....................................................................................
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences); //
  //! -- CacheHelper --------------------------------------------------------------------------------------------------------------
  sl.registerSingleton<LocaleCacheHelper>(LocaleCacheHelper(sharedPreferences: sl()));
  sl.registerSingleton<ThemeCacheHelper>(ThemeCacheHelper(sharedPreferences: sl()));
  //! -- Core --------------------------------------------------------------------------------------------------------------------
  sl.registerSingleton<AppMiddleWare>(AppMiddleWare(sharedPreferences: sl()));
  sl.registerSingleton<AppRouter>(AppRouter(appMiddleWare: sl()));
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<ApiConsumer>(DioConsumer(dio: sl()));
  //! -- Auth Domain and Data -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<AuthRepo>(AuthRepo(api: sl()));
  //! -- Payment Domain and Data -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<PaymentRepo>(PaymentRepo(api: sl()));
  //! -- Refferals Domain and Data -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<ReferalsRepo>(ReferalsRepo(api: sl()));
  //! -- Features -- onBorading and pick language ---------------------------------------------------------------------------------
  sl.registerSingleton<PickLanguageAndThemeCubit>(PickLanguageAndThemeCubit(
    sharedPreferences: sl(),
    localeCacheHelper: sl(),
    themeCacheHelper: sl(),
  ));
  //! -- Mainpage and advertise -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<AdvertiseRepo>(AdvertiseRepo(api: sl()));
  //! -- Features -- chat -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<ChatRepo>(ChatRepo(api: sl(), sharedPreferences: sl()));
  //! -- Features -- news -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<NewsRepo>(NewsRepo(api: sl()));
  //! -- Features -- support messages -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<SupportRepo>(SupportRepo(api: sl()));
}
