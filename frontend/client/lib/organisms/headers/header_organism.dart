import 'package:client/core/constants/app_text_style.dart';
import 'package:client/molecules/headers/page_header.dart';
import 'package:flutter/material.dart';

class HeaderOrganism extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final EdgeInsetsGeometry? padding;
  final Widget? trailing;

  const HeaderOrganism({
    super.key,
    required this.title,
    this.onBackPressed,
    this.padding,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: PageHeader(
        title: Center(child: Text(title, style: AppTextStyle.bodyLarge())),
        onBackPressed: onBackPressed,
        padding: padding,
        trailing: trailing,
      ),
    );
  }
}
