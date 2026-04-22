import 'package:client/templates/user/my_page_template.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  void onIdentityVerificationTap() {
    print("onIdentityVerificationTap");
  }

  void onPasswordResetTap() {
    print("onPasswordResetTap");
  }

  void onDeleteAccountTap() {
    print("onDeleteAccountTap");
  }

  void onBackPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyPageTemplate(
      onIdentityVerificationTap: onIdentityVerificationTap,
      onPasswordResetTap: onPasswordResetTap,
      onDeleteAccountTap: onDeleteAccountTap,
      onBackPressed: onBackPressed,
    );
  }
}
