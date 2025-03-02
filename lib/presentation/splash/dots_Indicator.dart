import 'package:flutter/material.dart';

import '../../core/styles/colors/app_colors.dart';

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int currentPosition;

  const DotsIndicator({
    super.key,
    required this.dotsCount,
    required this.currentPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        dotsCount,
            (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentPosition == index ? 24 : 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: currentPosition == index
                ? AppColors.kOrange  // Active dot color
                : Colors.grey.withOpacity(0.5),  // Inactive dot color
          ),
        ),
      ),
    );
  }
}
