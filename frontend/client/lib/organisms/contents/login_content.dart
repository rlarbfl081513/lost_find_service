import 'package:client/atoms/texts/title_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/molecules/buttons/kakao_button.dart';
import 'package:client/molecules/buttons/naver_button.dart';
import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  final String title;
  final String characterImagePath;
  final double containerRatio;
  final VoidCallback onKakaoPressed;
  final VoidCallback onNaverPressed;
  final VoidCallback onGuestPressed;
  const LoginContent({
    super.key,
    required this.title,
    required this.characterImagePath,
    required this.containerRatio,
    required this.onKakaoPressed,
    required this.onNaverPressed,
    required this.onGuestPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * containerRatio,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.black, width: 1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                TitleText(text: title),
                const SizedBox(height: 30),

                // 로그인 버튼들
                KakaoButton(onPressed: onKakaoPressed),
                const SizedBox(height: 12),
                NaverButton(onPressed: onNaverPressed),
                const SizedBox(height: 30),

                // 비회원 이용 링크
                GestureDetector(
                  onTap: onGuestPressed,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        '비회원으로 이용하기',
                        style: AppTextStyle.regular_14(color: AppColors.gray_1)
                            .copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.gray_1,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -140,
            right: 30,
            child: Image.asset(characterImagePath, width: 131),
          ),
        ],
      ),
    );
  }
}
