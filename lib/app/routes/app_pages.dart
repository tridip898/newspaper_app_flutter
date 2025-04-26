import 'package:get/get.dart';

import '../modules/bookmarked_news/bookmarked_news_binding.dart';
import '../modules/bookmarked_news/bookmarked_news_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/news_details/news_details_binding.dart';
import '../modules/news_details/news_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
  ];
}
