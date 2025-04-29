import 'package:get/get.dart';

class GlobalState extends GetxController {
  Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});
  @override
  void onInit() {
    super.onInit();
  }
}
