import 'package:client/templates/auth/identity_verification_template.dart';
import 'package:flutter/material.dart';

class IdentityVerificationPage extends StatefulWidget {
  const IdentityVerificationPage({super.key});

  @override
  State<IdentityVerificationPage> createState() =>
      _IdentityVerificationPageState();
}

class _IdentityVerificationPageState extends State<IdentityVerificationPage> {
  final String infoText = "본인인증을 위해\n신분증 또는 학생증을 준비해주세요.";

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onSkipPressed() {
    Navigator.pop(context);
  }

  void _onCameraPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return IdentityVerificationTemplate(
      onBackPressed: _onBackPressed,
      onSkipPressed: _onSkipPressed,
      onCameraPressed: _onCameraPressed,
      infoText: infoText,
    );
  }
}
