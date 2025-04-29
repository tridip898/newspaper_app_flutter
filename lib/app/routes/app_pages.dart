import 'package:get/get.dart';

import '../modules/bookmarked_news/bookmarked_news_binding.dart';
import '../modules/bookmarked_news/bookmarked_news_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/login_screen/login_screen_binding.dart';
import '../modules/login_screen/login_screen_view.dart';
import '../modules/news_details/news_details_binding.dart';
import '../modules/news_details/news_details_view.dart';
import '../modules/registration_screen/registration_screen_binding.dart';
import '../modules/registration_screen/registration_screen_view.dart';
import '../modules/splash_screen/splash_screen_binding.dart';
import '../modules/splash_screen/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAILS,
      page: () => const NewsDetailsView(),
      binding: NewsDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMARKED_NEWS,
      page: () => const BookmarkedNewsView(),
      binding: BookmarkedNewsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => const LoginScreenView(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION_SCREEN,
      page: () => const RegistrationScreenView(),
      binding: RegistrationScreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
  ];
}
