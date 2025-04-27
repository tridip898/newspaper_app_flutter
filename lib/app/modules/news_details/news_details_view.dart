import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newspaper_app_flutter/app/core/constraints/app_constraints.dart';
import 'package:newspaper_app_flutter/app/core/widget/app_network_image.dart';

import '../../core/constraints/app_colors.dart';
import '../../core/constraints/app_text_style.dart';
import 'news_details_controller.dart';

class NewsDetailsView extends GetView<NewsDetailsController> {
  const NewsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: mainPadding(20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImageProvider(
              controller.newsData.urlToImage,
              double.maxFinite,
              200.h,
              12.r,
            ),
            gapH8,
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: 18.w,
                  color: AppColors.secondaryColor,
                ),
                gapW8,
                Text(
                  DateFormat('hh:mm a | EEEE, MMMM dd, yyyy').format(
                    DateTime.parse(controller.newsData.publishedAt ?? ""),
                  ),
                  style: text13Style(color: AppColors.secondaryColor),
                ),
              ],
            ),
            gapH8,
            Text(
              controller.newsData.title ?? "",
              style: text16Style(isWeight600: true),
            ),
            gapH6,
            Text(
              "By ${controller.newsData.author ?? ""}",
              style: text14Style(color: Colors.grey.shade700),
            ),
            gapH12,
            Text(
              controller.newsData.description ?? "",
              style: text14Style(color: Colors.grey, isWeight400: true),
            ),
          ],
        ),
      ),
    );
  }
}
