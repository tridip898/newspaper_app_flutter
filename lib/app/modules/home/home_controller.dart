import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../core/constraints/app_constraints.dart';
import '../../data/model/bookmark_service.dart';
import '../../data/pojo/news_api_response_model.dart';
import '../../network/api_urls.dart';

class HomeController extends GetxController {
  final newsPaperData = <Articles>[].obs;
  final isDataLoaded = false.obs;
  final authController = Get.find<AuthController>();
  final bookmarks = <Articles>[].obs;

  @override
  void onInit() async {
    fetchNewPaperAPIData();
    loadBookmarkData();
    /* IconButton(
      onPressed: () {
        authController.logout();
      },
      icon: Icon(Icons.logout),
    )*/
    super.onInit();
  }

  void fetchNewPaperAPIData() async {
    var query = <String, dynamic>{};
    query['q'] = 'apple';
    query['from'] = '2025-04-25';
    query['to'] = '2025-04-25';
    query['sortBy'] = 'popularity';
    query['apiKey'] = apiKey;
    var response = await apiClient.getAPI(
      newsPaperUrl,
      fetchNewPaperAPIData,
      mQueryParameters: query,
      needLoader: false,
    );
    if (response != null) {
      isDataLoaded.value = true;
      var model = newsApiResponseModelFromJson(response.toString());
      if (model.status == okStatus) {
        newsPaperData.value = model.articles ?? [];
      } else {
        appWidget.showSimpleToast(
          model.message,
          isInfo: true,
        );
      }
    } else {
      appWidget.showSimpleToast(
        "Something Went Wrong",
        isInfo: true,
      );
    }
  }

  void loadBookmarkData() async {
    bookmarks.value = await BookmarkDatabase.instance.getBookmarks();
    bookmarks.refresh();
  }

  void bookmarkNews(Articles newspaperData) async {
    await BookmarkDatabase.instance.insertBookmark(newspaperData);
    appWidget.showSimpleToast(
      'Article bookmarked!',
      isSuccess: true,
      duration: 1,
    );
    loadBookmarkData();
  }
}
