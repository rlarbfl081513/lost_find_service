import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class MainTag extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Border? border;
  final double? height;
  final double? width;
  final bool isDeleteable;
  final Function()? onDelete;
  final double? iconSize;
  final double? spacing;
  final bool isSelected;

  const MainTag({
    super.key,
    this.text,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.textStyle,
    this.padding,
    this.borderRadius = 0,
    this.border,
    this.height,
    this.width,
    this.isDeleteable = false,
    this.onDelete,
    this.iconSize = 16,
    this.spacing = 5,
    this.isSelected = true,
  });

  @override
  Widget build(BuildContext context) {
    final currentBackgroundColor = isSelected
        ? (selectedBackgroundColor ?? AppColors.white)
        : (backgroundColor ?? withOpacityValue(Colors.black, 0));
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: currentBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius!),
        border: border ?? Border.all(color: AppColors.black, width: 0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text ?? "",
            style: textStyle ?? AppTextStyle.regular_12(color: Colors.black),
          ),
          if (isDeleteable) ...[
            SizedBox(width: spacing),
            GestureDetector(
              onTap: onDelete,
              child: Icon(Icons.close, color: AppColors.black, size: iconSize),
            ),
          ],
        ],
      ),
    );
  }
}
