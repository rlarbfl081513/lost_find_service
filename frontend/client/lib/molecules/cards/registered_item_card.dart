import 'package:client/atoms/buttons/basic_button.dart';
import 'package:client/atoms/texts/content_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class RegisteredItemCard extends StatelessWidget {
  final String categoryListString;
  final String date;
  final VoidCallback onTap;
  const RegisteredItemCard({
    super.key,
    required this.categoryListString,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      onPressed: onTap,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      backgroundColor: AppColors.white,
      borderRadius: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              ContentText(
                text: categoryListString,
                textStyle: AppTextStyle.bodyMedium(fontWeight: FontWeight.bold),
              ),
              ContentText(
                text: "$date 신고",
                textStyle: AppTextStyle.bodySmall(),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }
}
