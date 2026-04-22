import 'package:client/atoms/tags/main_tag.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  final List<String> tags;
  final bool isDeleteable;
  final Function(String)? onDelete;
  final Function(int)? onItemTap;
  final int? selectedIndex;
  final EdgeInsetsGeometry? padding;
  final double horizontalPadding;
  final TextStyle? textStyle;
  final bool isSelectable;

  const TagList({
    super.key,
    required this.tags,
    this.isDeleteable = false,
    this.onDelete,
    this.onItemTap,
    this.selectedIndex,
    this.padding,
    this.horizontalPadding = 20,
    this.textStyle,
    this.isSelectable = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tags.asMap().entries.map((entry) {
          int index = entry.key;
          String text = entry.value;
          bool isSelected = selectedIndex == index;
          if (isSelectable) {
            isSelected = true;
          }
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? horizontalPadding : 0,
              right: index < tags.length - 1 ? 10 : horizontalPadding,
            ),
            child: GestureDetector(
              onTap: onItemTap != null ? () => onItemTap!(index) : null,
              child: MainTag(
                text: text,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                borderRadius: 10,
                border: Border.all(color: AppColors.black, width: 1),
                textStyle:
                    textStyle ??
                    AppTextStyle.regular_12(color: AppColors.black),
                isDeleteable: isDeleteable,
                isSelected: isSelected,
                selectedBackgroundColor: AppColors.white,
                onDelete: onDelete != null ? () => onDelete!(text) : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
