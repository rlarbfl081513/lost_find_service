import 'package:client/atoms/buttons/basic_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class SubButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isPrimary;
  final double? width;
  final Color? backgroundColor;
  const SubButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isPrimary = false,
    this.width,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      width: width,
      onPressed: onPressed,
      backgroundColor: isPrimary
          ? AppColors.primary_1
          : backgroundColor ?? AppColors.gray_2,
      textColor: AppColors.black,
      borderRadius: 10,
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Text(
        text,
        style: AppTextStyle.bodyMedium(
          fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
          color: AppColors.black,
        ),
      ),
    );
  }
}
