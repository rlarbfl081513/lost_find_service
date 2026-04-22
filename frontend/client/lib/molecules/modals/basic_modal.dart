import 'package:client/atoms/texts/content_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BasicModal extends StatelessWidget {
  final String title;
  final Widget? guideSection;
  final Widget? infoMessage;
  final Widget? buttonSection;
  const BasicModal({
    super.key,
    required this.title,
    this.guideSection,
    this.infoMessage,
    this.buttonSection,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20), // 모달 크기 조절 패딩
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ), // 모달 모서리 둥글게
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: 16,
        ), // 모달 내부 패딩
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. 타이틀
            ContentText(text: title, textAlign: TextAlign.center),
            SizedBox(height: 24),

            // 2. 본인 확인 가이드 그림
            if (guideSection != null) ...[guideSection!, SizedBox(height: 14)],

            // 3. 안내문구
            if (infoMessage != null) ...[infoMessage!, SizedBox(height: 24)],

            // 4. 버튼
            if (buttonSection != null) ...[buttonSection!],
          ],
        ),
      ),
    );
  }
}
