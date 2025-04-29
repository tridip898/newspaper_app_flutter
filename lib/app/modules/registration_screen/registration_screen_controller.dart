import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class RegistrationScreenController extends GetxController {
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController();
  final nameFocus = FocusNode(),
      emailFocus = FocusNode(),
      passwordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();
  final errorMsg = "".obs, passwordText = "".obs;
  final isChecked = false.obs,
      isResendSuccess = false.obs,
      needToShowPassword = false.obs,
      needToShowConfirmPassword = false.obs;

  @override
  void onInit() {
    passwordController.addListener(() {
      passwordText.value = passwordController.text;
    });
    super.onInit();
  }

  setPasswordShow() {
    needToShowPassword.value = !needToShowPassword.value;
  }

  setConfirmPasswordShow() {
    needToShowConfirmPassword.value = !needToShowConfirmPassword.value;
  }

  void createBiker() {
    if (formKey.currentState?.validate() ?? false) {
      createBikerOperation();
    }
  }

  void createBikerOperation() {
    authController.register(emailController.text.trim(),
        passwordController.text.trim(), nameController.text.trim());
  }
}
