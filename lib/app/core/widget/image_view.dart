import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final String imageUrl;

  const ImageView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      minScale: PhotoViewComputedScale.contained * 0.8,
      imageProvider: CachedNetworkImageProvider(imageUrl),
    );
  }
}
