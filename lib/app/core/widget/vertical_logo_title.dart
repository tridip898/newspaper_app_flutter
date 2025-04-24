import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constraints/app_constraints.dart';
import '../constraints/app_text_style.dart';

class VerticalLogoTitle extends StatelessWidget {
  final String title;

  const VerticalLogoTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mainPadding(24, 0),
      child: Column(
        children: [
          Image.asset(
            "assets/png/colored_vertical_logo.png",
            width: 100.w,
            height: 68.w,
          ),
          gapH16,
          FittedBox(
            child: Text(
              title,
              style: text18Style(
                isSuzukiProHeadline: true,
                isWeight700: true,
                letterSpacing: 0.02,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
