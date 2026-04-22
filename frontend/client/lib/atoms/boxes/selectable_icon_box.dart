import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class SelectableIconBox extends StatelessWidget {
  final Widget icon;
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const SelectableIconBox({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    this.onTap,
    this.width = 60,
    this.height = 80,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.black : Colors.transparent,
            width: 1,
          ),
          borderRadius: isSelected ? BorderRadius.circular(10) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 4),
            Flexible(
              child: Text(
                text,
                style:
                    textStyle ?? AppTextStyle.bold_14(color: AppColors.black),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
