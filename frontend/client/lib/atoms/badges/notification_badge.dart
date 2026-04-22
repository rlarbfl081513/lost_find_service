import 'package:client/atoms/texts/content_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final int count;
  final Color? backgroundColor;
  final Color? textColor;
  const NotificationBadge({
    super.key,
    required this.count,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: backgroundColor ?? AppColors.primary_1,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      label: ContentText(
        text: count.toString(),
        textStyle: AppTextStyle.bodySmall(
          fontWeight: FontWeight.bold,
          color: textColor ?? AppColors.white,
        ),
      ),
    );
  }
}
