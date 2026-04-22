import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class ItemInfoSection extends StatelessWidget {
  final String title;
  final String content;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;

  const ItemInfoSection({
    super.key,
    required this.title,
    required this.content,
    this.titleStyle,
    this.contentStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ?? AppTextStyle.regular_12(color: AppColors.gray_1),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: contentStyle ?? AppTextStyle.bold_16(color: AppColors.black),
        ),
      ],
    );
  }
}
