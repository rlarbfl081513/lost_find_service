import 'package:client/atoms/buttons/icon_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final EdgeInsetsGeometry? padding;

  const CategoryHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        children: [
          IconButtonAtom(
            icon: Icons.arrow_back_ios_new,
            onPressed: onBackPressed,
            backgroundColor: AppColors.white,
          ),
          Expanded(
            child: Center(child: Text(title, style: AppTextStyle.bold_14())),
          ),
          SizedBox(width: 48),
        ],
      ),
    );
  }
}
