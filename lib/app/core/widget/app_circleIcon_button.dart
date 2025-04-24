import 'package:flutter/material.dart';

import '../constraints/app_colors.dart';
import '../constraints/app_constraints.dart';

class AppCircleIconButton extends StatelessWidget {
  final IconData iconName;
  final Color backgroundColor;
  final Function()? onTap;

  const AppCircleIconButton({
    super.key,
    required this.iconName,
    this.backgroundColor = AppColors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          padding: mainPadding(12, 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryColor)),
          child: Icon(
            iconName,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
