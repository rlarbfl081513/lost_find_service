import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const SectionTitle({super.key, required this.text, this.style, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: style ?? AppTextStyle.regular_10(color: Colors.black),
      ),
    );
  }
}
