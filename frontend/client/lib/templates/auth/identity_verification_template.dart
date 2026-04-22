import 'package:client/atoms/buttons/sub_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/molecules/buttons/button_group.dart';
import 'package:client/templates/common/basic_template.dart';
import 'package:flutter/material.dart';

class IdentityVerificationTemplate extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onSkipPressed;
  final VoidCallback onCameraPressed;
  final String infoText;
  const IdentityVerificationTemplate({
    super.key,
    required this.onBackPressed,
    required this.onSkipPressed,
    required this.onCameraPressed,
    this.infoText = "본인인증을 위해\n신분증 또는 학생증을 준비해주세요.",
  });

  @override
  Widget build(BuildContext context) {
    return BasicTemplate(
      onBackPressed: onBackPressed,
      title: "본인인증",
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    infoText,
                    style: AppTextStyle.title(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 20),
                // 카메라 영역
                Container(
                  width: double.infinity,
                  height: 200,
                  // color: AppColors.white,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                SubButton(
                  onPressed: onSkipPressed,
                  text: "다음에 하기",
                  width: 128,
                  backgroundColor: AppColors.white,
                ),
                Expanded(
                  child: SubButton(
                    onPressed: onCameraPressed,
                    text: "촬영 하기",
                    isPrimary: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
