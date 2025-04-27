import 'package:get/get.dart';
import 'package:newspaper_app_flutter/app/data/pojo/news_api_response_model.dart';

class NewsDetailsController extends GetxController {
  var newsData = Articles();

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments['data'] != null) {
      newsData = Get.arguments['data'];
    } else {
      Get.back();
    }
    super.onInit();
  }
}
