import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app_flutter/app/core/constraints/app_text_style.dart';

import '../../core/constraints/app_colors.dart';
import '../../core/constraints/app_constraints.dart';
import '../../core/widget/app_button.dart';
import '../../core/widget/app_edit_text.dart';
import '../../core/widget/my_rich_text.dart';
import 'registration_screen_controller.dart';

class RegistrationScreenView extends GetView<RegistrationScreenController> {
  const RegistrationScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0.13.sh,
            left: 0.02.h,
            right: 0.02.h,
            child: Column(
              children: [
                gapH(32),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "SIGN UP",
                    style: text20Style(),
                  ),
                ),
                gapH32,
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 2,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                padding: mainPadding(24, 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        return Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              AppEditText(
                                title: "Name",
                                hintText: "Name",
                                controller: controller.nameController,
                                focusNode: controller.nameFocus,
                                nextFocus: controller.emailFocus,
                                errorMsg: "Please enter your name",
                              ),
                              AppEditText(
                                title: "Email",
                                hintText: "Email",
                                controller: controller.emailController,
                                focusNode: controller.emailFocus,
                                nextFocus: controller.passwordFocusNode,
                                isEmail: true,
                                errorMsg: "Please enter your email",
                              ),
                              AppEditText(
                                title: "Password",
                                controller: controller.passwordController,
                                hintText: "Password",
                                needToShowEye: true,
                                errorMsg: "Enter your password",
                                minLength: 6,
                                isPassword:
                                    !controller.needToShowPassword.value,
                                eyeClick: controller.setPasswordShow,
                                focusNode: controller.passwordFocusNode,
                                nextFocus: controller.confirmPasswordFocusNode,
                              ),
                              AppEditText(
                                title: "Confirm Password",
                                controller:
                                    controller.confirmPasswordController,
                                hintText: "Confirm Password",
                                needToShowEye: true,
                                errorMsg: "Confirm your password",
                                minLength: 6,
                                isPassword:
                                    !controller.needToShowConfirmPassword.value,
                                eyeClick: controller.setConfirmPasswordShow,
                                passwordForConfirm:
                                    controller.passwordText.value,
                                focusNode: controller.confirmPasswordFocusNode,
                              ),
                              gapH8,
                              if (MediaQuery.of(context).viewInsets.bottom <=
                                  50)
                                appWidget.gapH(0.065.sh),
                              gapH24,
                              AppButton(
                                label: "Sign up",
                                onPressed: controller.createBiker,
                                fontSize: 14,
                                backgroundColor: AppColors.primaryColor,
                              ),
                              gapH24,
                              MyRichText(
                                firstText: "Already have an account?",
                                endText: "Login!",
                                isEndWeight600: true,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
