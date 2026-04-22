import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class SubTitleText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  const SubTitleText({super.key, required this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle ?? AppTextStyle.subTitle());
  }
}
