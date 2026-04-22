import 'package:client/atoms/buttons/sub_button.dart';
import 'package:client/molecules/modals/basic_modal.dart';
import 'package:flutter/material.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';

class IdentityVerificationModal extends StatelessWidget {
  final VoidCallback? onCancel;
  final bool isError;

  const IdentityVerificationModal({
    super.key,
    this.onCancel,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return BasicModal(
      title: "본인 확인",
      guideSection: Container(
        width: double.infinity,
        height: 148,
        decoration: BoxDecoration(
          color: Color(0xFFDBDBDB),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text("본인 확인 가이드 그림 추가 예정", style: AppTextStyle.bodyMedium()),
        ),
      ),
      infoMessage: isError
          ? Text(
              "인증 실패, 다시 촬영을 진행하겠습니다.",
              style: AppTextStyle.bodyMedium(
                fontWeight: FontWeight.w400,
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            )
          : Text(
              "본인확인을 위해 그림과 같이\n요기 머리에 있는 카메라 앞에 서주세요!",
              style: AppTextStyle.bodyMedium(fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
      buttonSection: SubButton(onPressed: onCancel, text: "취소"),
    );
  }
}
