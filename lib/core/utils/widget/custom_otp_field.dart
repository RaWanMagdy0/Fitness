import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../styles/colors/app_colors.dart';
import '../../styles/fonts/app_fonts.dart';

class CustomOTPField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autoFocus;
  final Function(String) onChanged;

  const CustomOTPField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.autoFocus = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppFonts.font20OrangeWeight500,
        decoration: InputDecoration(
          counterText: "",
          fillColor: Colors.white.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.kLighterGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.kOrange),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            onChanged(value);
          }
        },
      ),
    );
  }
}