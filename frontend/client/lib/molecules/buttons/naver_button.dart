import 'package:client/atoms/buttons/basic_button.dart';
import 'package:client/atoms/texts/content_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class NaverButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const NaverButton({
    super.key,
    this.onPressed,
    this.height = 30,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF03EB66),
      textColor: AppColors.white,
      borderRadius: 16,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: height,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.abc, size: 24, color: AppColors.white),
              const SizedBox(width: 10),
              ContentText(
                text: '네이버로 시작하기',
                textStyle: AppTextStyle.bodyMedium(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
