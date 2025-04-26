import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newspaper_app_flutter/app/core/widget/shimmer/shimmer_base.dart';

import '../constraints/app_assets.dart';
import '../constraints/app_constraints.dart';

class AppNetworkImageProvider extends StatelessWidget {
  final String? imagePath;
  final double width, padding, radius, height;
  final BoxFit fit;

  const AppNetworkImageProvider(
    this.imagePath,
    this.width,
    this.height,
    this.radius, {
    super.key,
    this.padding = 8,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    logger.i("");
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: appHelper.validateImageURL(imagePath ?? ""),
        height: height,
        width: width,
        fit: fit,
        progressIndicatorBuilder: (
          context,
          child,
          loadingProgress,
        ) {
          return ShimmerBase(
            child: SizedBox(
              height: height,
              width: width,
            ),
          );
        },
        errorWidget: (
          BuildContext context,
          String url,
          dynamic error,
        ) {
          logger.e(error);
          return SizedBox(
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(noImageFound),
            ),
          );
        },
      ),
    );
  }
}
