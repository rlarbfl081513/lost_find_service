import 'package:client/atoms/buttons/icon_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FloatingBackButton extends StatelessWidget {
  final VoidCallback onBackPressed;
  const FloatingBackButton({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      left: 20,
      child: IconButtonAtom(
        icon: Icons.arrow_back_ios_new,
        onPressed: onBackPressed,
        backgroundColor: AppColors.white,
        width: 40,
        height: 40,
      ),
    );
  }
}
