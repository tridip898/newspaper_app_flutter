import 'package:get/get.dart';

import 'bookmarked_news_controller.dart';

class BookmarkedNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarkedNewsController>(
      () => BookmarkedNewsController(),
    );
  }
}
