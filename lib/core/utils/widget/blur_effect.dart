import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlurEffect extends StatelessWidget {
  final Widget child;
  final double? sigmaX,
      sigmaY,
      topLeftBorderRadius,
      bottomLeftBorderRadius,
      topRightBorderRadius,
      bottomRightBorderRadius;

  const BlurEffect({
    super.key,
    required this.child,
    this.sigmaX,
    this.sigmaY,
    this.topLeftBorderRadius,
    this.bottomLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomRightBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeftBorderRadius ?? 0),
        bottomLeft: Radius.circular(bottomLeftBorderRadius ?? 16.r),
        topRight: Radius.circular(topRightBorderRadius ?? 0),
        bottomRight: Radius.circular(bottomRightBorderRadius ?? 16.r),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigmaX ?? 2,
          sigmaY: sigmaY ?? 2,
        ),
        child: child,
      ),
    );
  }
}
