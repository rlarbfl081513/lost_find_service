import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle title({
    Color color = AppColors.black,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
    String fontFamily = "Pretendard",
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  static TextStyle subTitle({
    Color color = AppColors.black,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
    String fontFamily = "Pretendard",
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  static TextStyle bodyLarge({
    Color color = AppColors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
    String fontFamily = "Pretendard",
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  static TextStyle bodyMedium({
    Color color = AppColors.black,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    String fontFamily = "Pretendard",
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  static TextStyle bodySmall({
    Color color = AppColors.black,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    String fontFamily = "Pretendard",
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  static TextStyle bold_24({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: color,
  );
  static TextStyle bold_20({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: color,
  );
  static TextStyle bold_16({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: color,
  );
  static TextStyle bold_14({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: color,
  );
  static TextStyle bold_12({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: color,
  );
  static TextStyle medium_20({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: color,
  );
  static TextStyle regular_20({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: color,
  );
  static TextStyle regular_16({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
  );
  static TextStyle regular_14({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
  );
  static TextStyle regular_12({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color,
  );
  static TextStyle regular_10({Color color = AppColors.black}) => TextStyle(
    fontFamily: "Pretendard",
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: color,
  );
}
