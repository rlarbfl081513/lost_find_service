import 'package:client/atoms/boxes/divider_line.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/molecules/grids/color_category_gird.dart';
import 'package:client/molecules/lists/main_category_list.dart';
import 'package:client/molecules/sections/category_section.dart';
import 'package:client/organisms/footers/filter_footer.dart';
import 'package:client/molecules/lists/tag_list.dart';
import 'package:client/organisms/contents/category_content.dart';
import 'package:client/models/Item/item_model.dart';
import 'package:client/organisms/headers/header_organism.dart';
import 'package:client/templates/common/basic_template.dart';
import 'package:flutter/material.dart';

class SearchCategoryPageTemplate extends StatelessWidget {
  final String headerTitle;
  final VoidCallback? onBackPressed;
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> colors;
  final int selectedCategoryIndex;
  final int selectedSubCategoryIndex;
  final int selectedSubSubCategoryIndex;
  final List<int> selectedColorIndexes;
  final Function(int)? onCategoryTap;
  final Function(int)? onSubCategoryTap;
  final Function(int)? onSubSubCategoryTap;
  final Function(int)? onColorTap;
  final int itemCount;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final EdgeInsetsGeometry? padding;

  const SearchCategoryPageTemplate({
    super.key,
    required this.headerTitle,
    this.onBackPressed,
    required this.categories,
    required this.colors,
    required this.selectedCategoryIndex,
    required this.selectedSubCategoryIndex,
    required this.selectedSubSubCategoryIndex,
    required this.selectedColorIndexes,
    this.onCategoryTap,
    this.onSubCategoryTap,
    this.onSubSubCategoryTap,
    this.onColorTap,
    required this.itemCount,
    required this.buttonText,
    this.onButtonPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // 선택된 카테고리의 서브 카테고리 가져오기
    List<String> subCategories = [];
    List<String> subSubCategories = [];

    if (selectedCategoryIndex >= 0 &&
        categories[selectedCategoryIndex]['category'] != null) {
      ItemCategoryModel selectedCategory =
          categories[selectedCategoryIndex]['category'];
      subCategories = selectedCategory.children
          .map((child) => child.name)
          .toList();

      // 서브 카테고리가 선택된 경우, 서브 서브 카테고리 가져오기
      if (selectedSubCategoryIndex >= 0 &&
          selectedSubCategoryIndex < selectedCategory.children.length) {
        ItemCategoryModel selectedSubCategory =
            selectedCategory.children[selectedSubCategoryIndex];
        subSubCategories = selectedSubCategory.children
            .map((child) => child.name)
            .toList();
      }
    }

    return BasicTemplate(
      title: headerTitle,
      onBackPressed: onBackPressed,
      body: Column(
        children: [
          Expanded(
            child: CategoryContent(
              sections: [
                Expanded(
                  flex: 1,
                  child: CategorySection(
                    title: "물품 종류",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 메인 카테고리
                        MainCategoryList(
                          categories: categories,
                          selectedCategoryIndex: selectedCategoryIndex,
                          onCategoryTap: onCategoryTap,
                        ),
                        // 서브 카테고리 (메인 카테고리 선택 시에만 표시)
                        if (selectedCategoryIndex >= 0 &&
                            subCategories.isNotEmpty) ...[
                          DividerLine(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                          TagList(
                            tags: subCategories,
                            onItemTap: (index) {
                              if (onSubCategoryTap != null) {
                                onSubCategoryTap!(index);
                              }
                            },
                            selectedIndex: selectedSubCategoryIndex,
                            textStyle: AppTextStyle.bodySmall(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        // 서브 서브 카테고리 (서브 카테고리 선택 시에만 표시)
                        if (selectedSubCategoryIndex >= 0 &&
                            subSubCategories.isNotEmpty) ...[
                          DividerLine(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                          TagList(
                            tags: subSubCategories,
                            onItemTap: (index) {
                              if (onSubSubCategoryTap != null) {
                                onSubSubCategoryTap!(index);
                              }
                            },
                            selectedIndex: selectedSubSubCategoryIndex,
                            textStyle: AppTextStyle.bold_12(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CategorySection(
                    title: "색상",
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ColorCategoryGrid(
                        colors: colors,
                        selectedColorIndexes: selectedColorIndexes,
                        onColorTap: onColorTap,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FilterFooter(
            itemCount: itemCount,
            buttonText: buttonText,
            onButtonPressed: onButtonPressed,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
