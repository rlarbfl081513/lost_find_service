import 'package:client/templates/auth/login_template.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // final VoidCallback onBackPressed;
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  void _onKakaoPressed() {
    // 카카오 로그인 로직
    // TODO: 카카오 로그인 로직 구현
  }

  void _onNaverPressed() {
    // 네이버 로그인 로직
    // TODO: 네이버 로그인 로직 구현
  }

  void _onGuestPressed() {
    // 비회원 이용 로직
    // TODO: 비회원 이용 로직 구현
  }

  final String title = '분실물 서비스\n"여기 있잖아" 입니다!';
  final String characterImagePath = 'assets/images/yogi.png';
  final double containerRatio = 0.7;

  @override
  Widget build(BuildContext context) {
    return LoginTemplate(
      title: title,
      characterImagePath: characterImagePath,
      containerRatio: containerRatio,
      onBackPressed: _onBackPressed,
      onKakaoPressed: _onKakaoPressed,
      onNaverPressed: _onNaverPressed,
      onGuestPressed: _onGuestPressed,
    );
  }
}
