import 'package:flutter/material.dart';
import 'package:client/core/constants/app_colors.dart';

class RobotPosition extends StatelessWidget {
  final Offset position;

  const RobotPosition({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * position.dx - 10,
      top: MediaQuery.of(context).size.height * position.dy - 10,
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: AppColors.primary_1,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.smart_toy, size: 12, color: AppColors.black),
      ),
    );
  }
}
