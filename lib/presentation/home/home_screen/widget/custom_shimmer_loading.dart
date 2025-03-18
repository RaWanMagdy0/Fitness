import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoadingWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFFEEEEEE),
      highlightColor: Color(0xFFD9D9D9),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
