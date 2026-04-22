import 'package:flutter/material.dart';
import 'package:client/core/constants/app_colors.dart';

class MapContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;

  const MapContainer({super.key, required this.child, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.gray_3,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black, width: 1),
      ),
      child: child,
    );
  }
}
