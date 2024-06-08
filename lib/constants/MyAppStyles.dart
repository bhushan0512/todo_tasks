import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/constants/MyAppColors.dart';

class MyAppStyles {
  TextStyle textfieldHint({
    double? fontSize,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: UIColor.DarkGrey,
    );
  }

  TextStyle textfieldText({
    double? fontSize,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: UIColor.Black,
    );
  }

  TextStyle buttonText({
    double? fontSize,
  }) {
    return GoogleFonts.inter(
      color: UIColor.Black,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle blackRegularInter({
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.inter(
      color: UIColor.Black,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );
  }

  TextStyle whiteRegularInter({
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.inter(
      color: UIColor.White,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );
  }

  TextStyle darkGreyRegularInter({
    double? fontSize,
  }) {
    return GoogleFonts.inter(
      color: UIColor.DarkGrey,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle semiBoldBlackRegularInter({
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.inter(
      color: UIColor.Black,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      decoration: decoration,
    );
  }

  TextStyle semiBoldWhiteRegularInter({
    double? fontSize,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.inter(
      color: UIColor.White,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      decoration: decoration,
    );
  }

  TextStyle boldBlackRegularInter({
    double? fontSize,
  }) {
    return GoogleFonts.prompt(
      color: UIColor.Black,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle greenRegularInter({
    double? fontSize,
  }) {
    return GoogleFonts.inter(
      color: UIColor.Green,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }
}
