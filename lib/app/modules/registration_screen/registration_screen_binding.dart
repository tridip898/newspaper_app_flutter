import 'package:get/get.dart';

import 'registration_screen_controller.dart';

class RegistrationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationScreenController>(
      () => RegistrationScreenController(),
    );
  }
}
