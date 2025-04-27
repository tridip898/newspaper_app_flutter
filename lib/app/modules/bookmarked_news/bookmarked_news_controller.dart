import 'package:get/get.dart';

import '../../core/constraints/app_constraints.dart';
import '../../data/model/bookmark_service.dart';
import '../../data/pojo/news_api_response_model.dart';

class BookmarkedNewsController extends GetxController {
  RxList<Articles> bookmarks = <Articles>[].obs;

  @override
  void onInit() async {
    bookmarks.value = await BookmarkDatabase.instance.getBookmarks();
    logger.i("bookmarks ${bookmarks.length}");
    super.onInit();
  }
}
