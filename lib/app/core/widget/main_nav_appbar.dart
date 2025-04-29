import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constraints/app_colors.dart';
import '../constraints/app_constraints.dart';

class MainNavAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool needLeading;
  final Function()? leadingPressed, bookmarkPressed;

  const MainNavAppBar(
      {super.key,
      this.needLeading = false,
      this.leadingPressed,
      this.bookmarkPressed,
      this.title});

  @override
  Widget build(BuildContext context) {
    appHelper.setStatusBarWhite();
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 50.w,
      leading: needLeading
          ? Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
            )
          : null,
      title: Text(title ?? ""),
      actions: [
        Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            // clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: bookmarkPressed,
              borderRadius: BorderRadius.circular(100),
              child: Center(
                child: Ink(
                  padding: mainPadding(8, 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.07),
                  ),
                  child: Icon(
                    Icons.bookmark_border_rounded,
                    size: 26.w,
                  ),
                ),
              ),
            ),
          ),
        ),
        gapW20,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
