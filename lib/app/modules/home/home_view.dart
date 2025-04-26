import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newspaper_app_flutter/app/core/constraints/app_colors.dart';
import 'package:newspaper_app_flutter/app/core/constraints/app_constraints.dart';
import 'package:newspaper_app_flutter/app/core/constraints/app_text_style.dart';
import 'package:newspaper_app_flutter/app/core/widget/app_network_image.dart';
import 'package:newspaper_app_flutter/app/data/pojo/news_api_response_model.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Newspaper",
          style: text16Style(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              if (!controller.isDataLoaded.value) {
                return Container();
              }
              if (controller.newsPaperData.isEmpty) {
                return Text("No Data Found");
              }
              return Expanded(
                child: ListView.separated(
                  padding: mainPadding(16, 16),
                  itemBuilder: (_, index) {
                    var newspaperData = controller.newsPaperData[index];
                    return newspaperCard(newspaperData);
                  },
                  separatorBuilder: (_, index) {
                    return gapH12;
                  },
                  itemCount: controller.newsPaperData.length,
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget newspaperCard(Articles newspaperData) {
    return Ink(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppNetworkImageProvider(
                newspaperData.urlToImage ?? "",
                double.maxFinite,
                150.h,
                20.r,
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 12.h,
                right: 12.w,
                child: Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: mainPadding(6, 6),
                    child: Icon(
                      Icons.bookmark_border_rounded,
                      size: 20.w,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              )
            ],
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
                  DateTime.parse(newspaperData.publishedAt ?? ""),
                ),
                style: text13Style(color: AppColors.secondaryColor),
              ),
            ],
          ),
          gapH3,
          Text(
            newspaperData.title ?? "",
            style: text16Style(
              isWeight600: true,
              letterSpacing: 0.02,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          gapH3,
          Text(
            "By ${newspaperData.author ?? ""}",
            style: text12Style(),
          ),
          gapH3,
          Text(
            newspaperData.description ?? "",
            style: text13Style(color: Colors.grey.shade600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
