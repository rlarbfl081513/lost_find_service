import 'package:client/organisms/contents/login_content.dart';
import 'package:client/templates/common/stack_template.dart';
import 'package:flutter/material.dart';

class LoginTemplate extends StatelessWidget {
  final String title;
  final String characterImagePath;
  final double containerRatio;
  final VoidCallback onBackPressed;
  final VoidCallback onKakaoPressed;
  final VoidCallback onNaverPressed;
  final VoidCallback onGuestPressed;
  const LoginTemplate({
    super.key,
    required this.title,
    required this.characterImagePath,
    required this.containerRatio,
    required this.onBackPressed,
    required this.onKakaoPressed,
    required this.onNaverPressed,
    required this.onGuestPressed,
  });

  @override
  Widget build(BuildContext context) {
    return StackTemplate(
      isBackButton: true,
      onBackPressed: onBackPressed,
      children: [
        // 로그인 컨테이너
        LoginContent(
          title: title,
          characterImagePath: characterImagePath,
          containerRatio: containerRatio,
          onKakaoPressed: onKakaoPressed,
          onNaverPressed: onNaverPressed,
          onGuestPressed: onGuestPressed,
        ),
      ],
    );
  }
}
