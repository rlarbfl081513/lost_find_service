import 'package:client/atoms/buttons/basic_button.dart';
import 'package:client/atoms/texts/content_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double borderRadius;
  final bool isEnabled;
  final double? paddingVertical;
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.borderRadius = 14,
    this.isEnabled = true,
    this.paddingVertical = 18,
  });

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = isEnabled ? FontWeight.w700 : FontWeight.w400;
    Color textColor = isEnabled ? AppColors.black : AppColors.gray_1;
    return BasicButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      textColor: textColor,
      height: height,
      borderRadius: borderRadius,
      padding: EdgeInsets.symmetric(vertical: 18),
      isEnabled: isEnabled,
      child: ContentText(
        text: text,
        textStyle: AppTextStyle.bodyLarge(
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );
  }
}
