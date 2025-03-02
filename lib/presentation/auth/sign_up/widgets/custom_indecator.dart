import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const ProgressIndicatorWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    double progressValue = currentPage / totalPages;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: CircularProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.grey[300],
            valueColor:  AlwaysStoppedAnimation<Color>(AppColors.kOrange),
            strokeWidth: 2,
          ),
        ),
        Text(
          "$currentPage/$totalPages",
          style:  AppFonts.font14WhiteWeight400
        ),
      ],
    );
  }
}
