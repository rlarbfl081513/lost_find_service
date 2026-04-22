import 'package:client/atoms/buttons/basic_button.dart';
// import 'package:client/atoms/buttons/main_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class ReportButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final String? backgroundImagePath;
  final Offset? backgroundImageOffset;

  const ReportButton({
    super.key,
    required this.title,
    this.onPressed,
    this.padding,
    this.backgroundImagePath = 'assets/images/yogi.png',
    this.backgroundImageOffset = const Offset(27, -35),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(top: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 배경 이미지
          if (backgroundImagePath != null || backgroundImagePath!.isNotEmpty)
            Positioned(
              left: backgroundImageOffset?.dx ?? 0,
              top: backgroundImageOffset?.dy ?? 0,
              child: Transform.scale(
                scaleX: -1,
                child: Image.asset(backgroundImagePath!, width: 42),
              ),
            ),
          // 메인 버튼
          BasicButton(
            borderRadius: 20,
            backgroundColor: AppColors.white,
            onPressed: onPressed,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.share_arrival_time, size: 24),
                Row(
                  children: [
                    Text(title, style: AppTextStyle.bodySmall()),
                    Icon(Icons.keyboard_arrow_right_outlined, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
