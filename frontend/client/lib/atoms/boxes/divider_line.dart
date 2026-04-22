import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  final double height;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const DividerLine({
    super.key,
    this.height = 1,
    this.color = const Color(0xffE5E5E5),
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 16),
      child: Container(height: height, width: double.infinity, color: color),
    );
  }
}
