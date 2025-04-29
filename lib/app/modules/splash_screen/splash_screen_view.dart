import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          controller.logo,
          fit: BoxFit.fill,
        ).animate().scaleXY(
              begin: 0,
              end: .6,
              duration: const Duration(milliseconds: 2000),
            ),
      ),
    );
  }
}
