import 'package:get/get.dart';

import 'news_details_controller.dart';

class NewsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailsController>(
      () => NewsDetailsController(),
    );
  }
}
