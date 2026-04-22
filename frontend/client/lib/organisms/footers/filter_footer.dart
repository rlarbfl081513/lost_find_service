import 'package:client/atoms/buttons/main_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class FilterFooter extends StatelessWidget {
  final int itemCount;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final EdgeInsetsGeometry? padding;

  const FilterFooter({
    super.key,
    required this.itemCount,
    required this.buttonText,
    this.onButtonPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Row(
            children: [
              Icon(Icons.refresh),
              Text("$itemCount개", style: AppTextStyle.bold_16()),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: MainButton(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.primary_1,
              onPressed: onButtonPressed,
              child: Text(buttonText, style: AppTextStyle.bold_16()),
            ),
          ),
        ],
      ),
    );
  }
}
