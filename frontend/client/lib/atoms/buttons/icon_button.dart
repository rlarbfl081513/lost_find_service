import 'package:client/atoms/buttons/main_button.dart';
import 'package:flutter/material.dart';

class IconButtonAtom extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? borderRadius;

  const IconButtonAtom({
    super.key,
    required this.icon,
    this.size = 16,
    this.onPressed,
    this.width = 48,
    this.height = 48,
    this.backgroundColor,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return MainButton(
      onPressed: onPressed,
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      child: Icon(icon, size: size),
    );
  }
}
