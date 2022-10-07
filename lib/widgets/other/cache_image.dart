import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  const CustomCacheNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.boxFit,
  }) : super(key: key);
  final String imageUrl;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      progressIndicatorBuilder: (context, url, status) {
        return Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Container(
            color: Colors.white,
          ),
        );
      },
      errorWidget: (context, url, whatever) {
        return const Text("Image not available");
      },
      imageUrl: imageUrl,
      fit: boxFit,
    );
  }
}
