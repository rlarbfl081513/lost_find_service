import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const LogoText({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? withOpacityValue(AppColors.black, 0.4),
        ),
      ),
    );
  }
}
