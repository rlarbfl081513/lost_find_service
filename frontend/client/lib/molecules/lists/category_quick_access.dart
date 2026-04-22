import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class CategoryQuickAccess extends StatelessWidget {
  final List<String> categories;
  final Function(String)? onCategoryTap;
  final EdgeInsetsGeometry? padding;

  const CategoryQuickAccess({
    super.key,
    required this.categories,
    this.onCategoryTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 83,
      child: ListView.separated(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 14),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: onCategoryTap != null
                ? () => onCategoryTap!(categories[index])
                : null,
            child: SizedBox(
              width: 60,
              height: 83,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 36),
                  SizedBox(height: 8),
                  Text(
                    categories[index],
                    style: AppTextStyle.bold_14(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
