import 'package:get/get.dart';

import '../../network/api_client.dart';
import '../../network/api_urls.dart';
import '../constraints/app_constraints.dart';

class GlobalState extends GetxController {
  // final userDetails = Data().obs;
  // final selectedBike = selected_bike.BikeList().obs;
  // final bikeListData = <selected_bike.BikeList>[].obs;
  // final drivingLicenceFontSideImg = "".obs,
  //     drivingLicenceBackSideImg = "".obs,
  //     brtaRegFontSideImg = "".obs,
  //     brtaRegBackSideImg = "".obs,
  //     insurancePaperImg = "".obs,
  //     otherDocumentImg = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  logoutSection() async {
    var response = await ApiClient().getAPI(logOutUrl, logoutSection);
    if (response != null) {
      appHelper.logout();
    }
  }
}
