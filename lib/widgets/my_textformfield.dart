import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/MyAppColors.dart';
import 'package:todo/constants/MyAppStyles.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final String? initialValue;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.keyboardType,
    this.inputAction,
    this.suffixIcon,
    this.padding,
    this.maxLines,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    int? adjustedMaxLines =
        obscureText && (maxLines == null || maxLines! > 1) ? 1 : maxLines;

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 25.w),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: adjustedMaxLines,
        cursorColor: UIColor.Black,
        cursorErrorColor: UIColor.Red,
        textInputAction: inputAction,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        style: MyAppStyles().textfieldText(fontSize: 16.sp),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: UIColor.Grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: UIColor.GreyStroke),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: UIColor.Red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: UIColor.Red),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: MyAppStyles().textfieldHint(fontSize: 16.sp),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w, vertical: 16.h), // Adjust padding here
        ),
      ),
    );
  }
}
