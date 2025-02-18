import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../styles/colors/app_colors.dart';
import '../../styles/fonts/app_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? initialTextValue, obscuringCharacter;
  final int? maxLength, maxLines, minLines, errorMaxLines;
  final bool? enabled, isPassword, isFilled;
  final TextStyle? inputTextStyle, hintStyle, errorStyle;
  final Color? backgroundColor, disabledBackgroundColor, suffixIconColor;
  final InputBorder? border,
      enabledBorder,
      focusedBorder,
      disabledBorder,
      errorBorder,
      focusedErrorBorder;
  final Color? borderColor,
      enabledBorderColor,
      focusedBorderColor,
      errorBorderColor,
      focusedErrorBorderColor;
  final double? borderWidth,
      enabledBorderWidth,
      focusedBorderWidth,
      disabledBorderWidth,
      errorBorderWidth,
      focusedErrorBorderWidth;
  final double? borderRadius,
      enabledBorderRadius,
      focusedBorderRadius,
      disabledBorderRadius,
      errorBorderRadius,
      focusedErrorBorderRadius;
  final num? scrollPaddingValue;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyBordType;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged, onFieldSubmitted, onSaved;
  final void Function()? onEditingComplete, onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon, prefixIcon;
  final IconData? icon;
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
     this.hintText,
    this.labelText,
    this.textInputAction,
    this.autovalidateMode,
    this.border,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.controller,
    this.disabledBackgroundColor,
    this.disabledBorder,
    this.disabledBorderWidth,
    this.disabledBorderRadius,
    this.enabled,
    this.enabledBorder,
    this.enabledBorderColor,
    this.enabledBorderWidth,
    this.enabledBorderRadius,
    this.errorBorder,
    this.errorBorderColor,
    this.errorBorderWidth,
    this.errorBorderRadius,
    this.errorMaxLines,
    this.errorStyle,
    this.backgroundColor,
    this.focusNode,
    this.focusedBorder,
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.focusedBorderRadius,
    this.focusedErrorBorder,
    this.focusedErrorBorderColor,
    this.focusedErrorBorderWidth,
    this.focusedErrorBorderRadius,
    this.hintStyle,
    this.icon,
    this.initialTextValue,
    this.inputFormatters,
    this.isFilled,
    this.isPassword,
    this.keyBordType,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.obscuringCharacter,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.contentPadding,
    this.prefixIcon,
    this.inputTextStyle,
    this.scrollPaddingValue,
    this.suffixIcon,
    this.suffixIconColor,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isTextObscured;
  int? maxLines;

  @override
  void initState() {
    super.initState();
    // MaxLines must equals 1 if obscureText is true
    if (widget.isPassword != null && widget.isPassword!) {
      isTextObscured = true;
      maxLines = 1;
    } else {
      isTextObscured = false;
      maxLines = widget.maxLines;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialTextValue,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTap: widget.onTap,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: isTextObscured,
      obscuringCharacter: widget.obscuringCharacter ?? '*',
      maxLength: widget.maxLength,
      maxLines: maxLines,
      minLines: widget.minLines,
      keyboardType: widget.keyBordType,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      scrollPadding: widget.scrollPaddingValue == null
          ? const EdgeInsets.all(20.0)
          : EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  (widget.scrollPaddingValue!)),
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.labelText,
        floatingLabelStyle:
            WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.focused)) {
            return TextStyle(color: AppColors.kOrange);
          } else if (states.contains(WidgetState.error)) {
            return TextStyle(color: AppColors.kError);
          }
          return TextStyle(color: Colors.grey);
        }),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? AppFonts.font14GreyWeight400,
        fillColor: (widget.enabled != null && widget.enabled == false)
            ? widget.disabledBackgroundColor ?? AppColors.kLighterGrey
            : widget.backgroundColor ?? AppColors.kLighterGrey,
        filled: widget.isFilled ?? true,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: AppColors.kOrange,
        suffixIcon: widget.isPassword ?? false
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isTextObscured = !isTextObscured;
                  });
                },
                child: Icon(
                  color: AppColors.kLighterGrey,
                  isTextObscured ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : widget.suffixIcon,
        counterText: "",
        border: widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 25.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.kLighterGrey,
                width: widget.borderWidth ?? 1,
              ),
            ),
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.enabledBorderRadius ?? 25.r),
              borderSide: BorderSide(
                color: widget.enabledBorderColor ?? AppColors.kLighterGrey,
                width: widget.enabledBorderWidth ?? 1,
              ),
            ),
        focusedBorder: widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.focusedBorderRadius ?? 25.r),
              borderSide: BorderSide(
                color: widget.focusedBorderColor ?? AppColors.kOrange,
                width: widget.focusedBorderWidth ?? 1,
              ),
            ),
        disabledBorder: widget.disabledBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.disabledBorderRadius ?? 25.r),
              borderSide: BorderSide(
                color:
                    widget.disabledBackgroundColor ?? AppColors.kLighterGrey,
                width: widget.disabledBorderWidth ?? 1,
              ),
            ),
        errorStyle: widget.errorStyle ??
            TextStyle(color: AppColors.kError, fontSize: 14.sp),
        errorMaxLines: widget.errorMaxLines ?? 4,
        errorBorder: widget.errorBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.errorBorderRadius ?? 25.r),
              borderSide: BorderSide(
                color: widget.errorBorderColor ?? AppColors.kError,
                width: widget.errorBorderWidth ?? 1,
              ),
            ),
        focusedErrorBorder: widget.focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.focusedErrorBorderRadius ?? 25.r),
              borderSide: BorderSide(
                color: widget.focusedErrorBorderColor ?? AppColors.kError,
                width: widget.focusedErrorBorderWidth ?? 1,
              ),
            ),
      ),
    );
  }
}
