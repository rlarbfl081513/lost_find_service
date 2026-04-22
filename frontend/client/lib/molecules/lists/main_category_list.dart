import 'package:client/atoms/boxes/selectable_icon_box.dart';
import 'package:flutter/material.dart';

class MainCategoryList extends StatelessWidget {
  const MainCategoryList({
    super.key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.onCategoryTap,
  });

  final List<Map<String, dynamic>> categories;
  final int selectedCategoryIndex;
  final Function(int p1)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> category = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              right: index < categories.length - 1 ? 14 : 0,
            ),
            child: SelectableIconBox(
              icon: category['icon'],
              text: category['text'],
              // textStyle: AppTextStyle.bold_12(),
              isSelected: selectedCategoryIndex == index,
              onTap: onCategoryTap != null ? () => onCategoryTap!(index) : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}
