// import 'package:client/molecules/category_section.dart';
import 'package:flutter/material.dart';

class CategoryContent extends StatelessWidget {
  final List<Widget> sections;
  final EdgeInsetsGeometry? padding;

  const CategoryContent({super.key, required this.sections, this.padding});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sections,
            ),
          ),
        ],
      ),
    );
  }
}
