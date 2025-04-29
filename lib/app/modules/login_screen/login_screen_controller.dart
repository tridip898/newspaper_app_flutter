import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class LoginScreenController extends GetxController {
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController(),
      emailController = TextEditingController();
  final emailFocus = FocusNode(), passwordFocus = FocusNode();
  final isNeedToShowPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  setNeedToShowPassword() {
    isNeedToShowPassword.value = !isNeedToShowPassword.value;
  }

  void loginClick() {
    if (formKey.currentState?.validate() ?? false) {
      loginOperation();
    }
  }

  void loginOperation() {
    authController.login(
        emailController.text.trim(), passwordController.text.trim());
  }
}
