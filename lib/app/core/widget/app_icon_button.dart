import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constraints/app_colors.dart';
import '../constraints/app_constraints.dart';
import '../constraints/app_text_style.dart';

class AppIconButton extends StatelessWidget {
  final String? title, iconName;
  final Function()? onTap;

  const AppIconButton({super.key, this.title, this.iconName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: AppColors.primaryColor,
          width: 1,
        ),
      ),
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Ink(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconName ?? "",
                height: 20.w,
                width: 20.w,
              ),
              gapW12,
              Text(
                title ?? "",
                style: text14Style(
                  isWeight500: true,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
