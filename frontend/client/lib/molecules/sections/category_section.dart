import 'package:client/atoms/texts/section_title.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CategorySection({
    super.key,
    required this.title,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: title,
          style: AppTextStyle.bold_14(),
          padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
        ),
        SizedBox(height: 8),
        SizedBox(width: double.infinity, child: child),
      ],
    );
  }
}
