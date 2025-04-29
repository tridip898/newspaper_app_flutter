import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app_flutter/app/core/widget/shimmer/shimmer_base.dart';

import '../../constraints/app_constraints.dart';

class ShimmerWidgets {
  rowShimmer({
    double leftWidth = 50.0,
    double rightWidth = 60.0,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 18,
            width: leftWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
          ),
          Container(
            height: 18,
            width: rightWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  titleShimmer({double? width}) {
    width = width ?? Get.width * .4;
    return Container(
      height: 18,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
    );
  }

  Widget newsListShimmer() {
    return Container(
      margin: mainPadding(16, 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ]),
      padding: mainPadding(12, 12),
      child: ShimmerBase(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: 140.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            gapH6,
            titleShimmer(width: 0.4.sw),
            gapH6,
            titleShimmer(width: 0.8.sw),
            gapH6,
            titleShimmer(width: 0.3.sw),
          ],
        ),
      ),
    );
  }
}
