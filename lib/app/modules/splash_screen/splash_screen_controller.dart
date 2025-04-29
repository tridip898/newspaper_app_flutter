import 'package:get/get.dart';
import 'package:newspaper_app_flutter/app/routes/app_pages.dart';

import '../../controller/auth_controller.dart';
import '../../core/constraints/app_assets.dart';

class SplashScreenController extends GetxController {
  final authController = Get.find<AuthController>();
  final logo = newsPaperLogo;

  @override
  void onInit() {
    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        checkSignInUser();
      },
    );

    super.onInit();
  }

  void checkSignInUser() {
    if (authController.user != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN_SCREEN);
    }
  }
}
