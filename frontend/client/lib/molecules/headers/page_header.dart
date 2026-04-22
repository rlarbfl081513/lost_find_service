import 'package:client/atoms/buttons/icon_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final Widget title;
  final VoidCallback? onBackPressed;
  final EdgeInsetsGeometry? padding;
  final Widget? trailing;
  final double frontSpacing;
  final double trailingSpacing;

  const PageHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.padding,
    this.trailing,
    this.frontSpacing = 0,
    this.trailingSpacing = 0,
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
            width: 40,
            height: 40,
          ),
          SizedBox(width: frontSpacing),
          Expanded(child: title),
          SizedBox(width: trailingSpacing),
          trailing ?? SizedBox(width: 40),
        ],
      ),
    );
  }
}
