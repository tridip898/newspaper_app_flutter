import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constraints/app_colors.dart';
import '../../core/constraints/app_constraints.dart';
import '../../core/widget/app_button.dart';
import '../../core/widget/app_edit_text.dart';
import '../../core/widget/my_rich_text.dart';
import '../../routes/app_pages.dart';
import 'login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            gapH30,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.14),
                      blurRadius: 2,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                padding: mainPadding(24, 20),
                child: Obx(() {
                  return Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppEditText(
                            title: "",
                            hintText: "Email",
                            controller: controller.emailController,
                            focusNode: controller.emailFocus,
                            nextFocus: controller.passwordFocus,
                            isMobileNumber: true,
                            errorMsg: "Please enter mobile number",
                            needMobilePrefix: true,
                          ),
                          gapH8,
                          AppEditText(
                            title: "",
                            hintText: "Password",
                            controller: controller.passwordController,
                            focusNode: controller.passwordFocus,
                            errorMsg: "Please enter your password",
                            needPasswordPrefix: true,
                            minLength: 6,
                            isPassword: !controller.isNeedToShowPassword.value,
                            needToShowEye: true,
                            eyeClick: controller.setNeedToShowPassword,
                          ),
                          gapH(32),
                          AppButton(
                            label: "Login",
                            fontSize: 14,
                            onPressed: controller.loginClick,
                            backgroundColor: AppColors.primaryColor,
                          ),
                          gapH24,
                          MyRichText(
                            firstText: "Don't have an account?",
                            endText: "Sign up!",
                            isEndWeight600: true,
                            onTap: () {
                              Get.toNamed(Routes.REGISTRATION_SCREEN);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
