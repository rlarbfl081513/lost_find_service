import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const LogoContainer({
    super.key,
    required this.imagePath,
    this.width = 19,
    this.height = 19,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Image.asset(imagePath, width: width, height: height),
    );
  }
}
