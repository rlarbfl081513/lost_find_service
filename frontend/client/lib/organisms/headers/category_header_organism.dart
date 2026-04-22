import 'package:client/molecules/headers/category_header.dart';
import 'package:flutter/material.dart';

class CategoryHeaderOrganism extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final EdgeInsetsGeometry? padding;

  const CategoryHeaderOrganism({
    super.key,
    required this.title,
    this.onBackPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CategoryHeader(
        title: title,
        onBackPressed: onBackPressed,
        padding: padding,
      ),
    );
  }
}
