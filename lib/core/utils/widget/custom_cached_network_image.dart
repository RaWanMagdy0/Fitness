import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/utils/widget/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;
  final double? shimmerWidth, shimmerHeight, shimmerRadiusValue;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Color? shimmerBaseColor, shimmerHighlightColor;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomCachedNetworkImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.shimmerWidth,
    this.shimmerHeight,
    this.shimmerRadiusValue,
    this.fit,
    this.borderRadius,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "http://via.placeholder.com/350x150",
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          ShimmerLoadingWidget(
            width: shimmerWidth ?? 24,
            height: shimmerHeight ?? 24,
            borderRadius: shimmerRadiusValue,
          ),
      errorWidget: (context, url, error) => errorWidget ?? Icon(Icons.error),
    );
  }
}
