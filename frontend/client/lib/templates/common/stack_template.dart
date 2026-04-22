import 'package:client/core/constants/app_colors.dart';
import 'package:client/molecules/buttons/floating_back_button.dart';
import 'package:flutter/material.dart';

class StackTemplate extends StatelessWidget {
  final bool isBackButton;
  final VoidCallback? onBackPressed;
  final Clip clipBehavior;
  final List<Widget> children;

  const StackTemplate({
    super.key,
    this.isBackButton = false,
    this.onBackPressed,
    this.clipBehavior = Clip.none,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray_2,
      body: Stack(
        clipBehavior: clipBehavior,
        children: [
          if (isBackButton)
            FloatingBackButton(onBackPressed: onBackPressed ?? () {}),
          ...children,
        ],
      ),
    );
  }
}
