import 'package:client/atoms/boxes/selectable_icon_box.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class ColorCategoryGrid extends StatelessWidget {
  const ColorCategoryGrid({
    super.key,
    required this.colors,
    required this.selectedColorIndexes,
    required this.onColorTap,
  });

  final List<Map<String, dynamic>> colors;
  final List<int> selectedColorIndexes;
  final Function(int p1)? onColorTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 46 / 62,
        crossAxisSpacing: 8,
        mainAxisSpacing: 6,
      ),
      itemCount: colors.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> color = colors[index];
        return SelectableIconBox(
          icon: color['icon'],
          text: color['text'],
          isSelected: selectedColorIndexes.contains(index),
          onTap: onColorTap != null ? () => onColorTap!(index) : null,
          width: 46,
          height: 62,
          textStyle: AppTextStyle.regular_12(color: AppColors.black),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        );
      },
    );
  }
}
