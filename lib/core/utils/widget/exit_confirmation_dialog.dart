import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/colors/app_colors.dart';
import '../../styles/fonts/app_fonts.dart';


class ExitConfirmationDialog {
  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kBlackBG.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.all(20.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are You Sure To Close The Application?',
              style: AppFonts.font16WhiteWeight500,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // No button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    minimumSize: Size(80.w, 40.h),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'NO',
                    style: AppFonts.font14WhiteWeight400,
                  ),
                ),
                // Yes button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    minimumSize: Size(80.w, 40.h),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'YES',
                    style: AppFonts.font14WhiteWeight400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ) ??
        false;
  }
}