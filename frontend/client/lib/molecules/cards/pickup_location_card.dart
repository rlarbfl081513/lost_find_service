import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class PickupLocationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const PickupLocationCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: AppColors.black),
            const SizedBox(width: 4),
            Text(title, style: AppTextStyle.regular_12(color: AppColors.black)),
          ],
        ),
      ),
    );
  }
}
