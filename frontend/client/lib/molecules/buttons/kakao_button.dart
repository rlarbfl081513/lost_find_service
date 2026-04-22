import 'package:client/atoms/buttons/basic_button.dart';
import 'package:client/atoms/texts/content_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class KakaoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const KakaoButton({
    super.key,
    this.onPressed,
    this.height = 30,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFFFAE100),
      textColor: AppColors.black,
      borderRadius: 16,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: height,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.abc, size: 24),
              const SizedBox(width: 10),
              ContentText(
                text: '카카오로 시작하기',
                textStyle: AppTextStyle.bodyMedium(
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
