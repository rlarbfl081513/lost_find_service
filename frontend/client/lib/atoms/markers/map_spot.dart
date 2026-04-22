import 'package:flutter/material.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';

class MapSpot extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Offset position;

  const MapSpot({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * position.dx - 15,
      top: MediaQuery.of(context).size.height * 0.3 * position.dy - 15,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isSelected ? 30 : 20,
          height: isSelected ? 30 : 20,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary_1 : AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppColors.primary_1 : AppColors.gray_1,
              width: 2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary_1.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyle.bold_12(
                color: isSelected ? AppColors.black : AppColors.gray_1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
