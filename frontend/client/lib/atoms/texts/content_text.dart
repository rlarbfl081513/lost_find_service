import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class ContentText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  const ContentText({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? AppTextStyle.bodyLarge(),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
