import 'package:flutter/material.dart';
import 'package:client/core/constants/app_colors.dart';

class BasicButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final bool isEnabled;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final double? width;

  const BasicButton({
    super.key,
    this.child,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.borderRadius = 10,
    this.padding,
    this.isEnabled = true,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? (backgroundColor ?? AppColors.primary_1)
              : (disabledBackgroundColor ?? AppColors.white),
          foregroundColor: isEnabled
              ? (textColor ?? AppColors.black)
              : (disabledTextColor ?? AppColors.gray_3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          elevation: 0,
          splashFactory: InkSparkle.splashFactory,
          overlayColor: isEnabled ? Colors.grey : Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: child,
      ),
    );
  }
}
