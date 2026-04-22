import 'package:flutter/material.dart';

class HeroText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const HeroText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w900,
    this.height = 1.4,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          color: color,
        ),
      ),
    );
  }
}
