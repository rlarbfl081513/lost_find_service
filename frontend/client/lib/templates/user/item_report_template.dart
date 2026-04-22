import 'dart:io';
import 'package:client/atoms/buttons/basic_button.dart';
import 'package:client/atoms/buttons/primary_button.dart';
import 'package:client/atoms/inputs/common_input.dart';
import 'package:client/atoms/texts/content_text.dart';
import 'package:client/atoms/texts/sub_title_text.dart';
import 'package:client/atoms/texts/title_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/models/Item/item_model.dart';
import 'package:client/molecules/grids/color_category_gird.dart';
import 'package:client/molecules/lists/main_category_list.dart';
import 'package:client/molecules/lists/tag_list.dart';
import 'package:client/molecules/sections/category_section.dart';
import 'package:client/templates/common/basic_template.dart';
import 'package:flutter/material.dart';

class ItemReportTemplate extends StatelessWidget {
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
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onAddImagePressed;
  final TextEditingController? descriptionController; // 설명 입력 컨트롤러
  final Function(String)? onDescriptionChanged; // 설명 변경 콜백
  final List<File> selectedImages; // 선택된 이미지들
  final Function(int)? onRemoveImage; // 이미지 삭제 콜백
  const ItemReportTemplate({
    super.key,
    required this.headerTitle,
    required this.onBackPressed,
    required this.categories,
    required this.colors,
    required this.selectedCategoryIndex,
    required this.selectedSubCategoryIndex,
    required this.selectedSubSubCategoryIndex,
    required this.selectedColorIndexes,
    required this.onCategoryTap,
    required this.onSubCategoryTap,
    required this.onSubSubCategoryTap,
    required this.onColorTap,
    required this.buttonText,
    required this.onButtonPressed,
    required this.onAddImagePressed,
    this.descriptionController,
    this.onDescriptionChanged,
    this.selectedImages = const [],
    this.onRemoveImage,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleText(
                    text: "무엇을 잃어버렸나요??",
                    textStyle: AppTextStyle.title(fontWeight: FontWeight.w400),
                  ),
                  ContentText(
                    text: "★ 필수 입력 사항",
                    textStyle: AppTextStyle.bodySmall(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CategorySection(
                  title: "1차 카테고리 ★",
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
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SubTitleText(
                            text: "2차 카테고리 ★",
                            textStyle: AppTextStyle.subTitle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
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
                        SizedBox(height: 16),
                      ],
                      // 서브 서브 카테고리 (서브 카테고리 선택 시에만 표시)
                      if (selectedSubCategoryIndex >= 0 &&
                          subSubCategories.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SubTitleText(
                            text: "3차 카테고리",
                            textStyle: AppTextStyle.subTitle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
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
                        SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
                CategorySection(
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
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    text: "더 자세한 설명을 해주세요!",
                    textStyle: AppTextStyle.title(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20, width: double.infinity),
                  SubTitleText(text: "분실물 설명 작성"),
                  SizedBox(height: 8),
                  CommonInput(
                    controller: descriptionController,
                    onChanged: onDescriptionChanged,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    fillColor: AppColors.white,
                    hintText: "예) 귀여운 곰돌이 그립톡이 붙어있어요ㅠㅠㅠ",
                    hintStyle: AppTextStyle.subTitle(color: AppColors.gray_1),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                    textStyle: AppTextStyle.subTitle(color: AppColors.black),
                  ),
                  SizedBox(height: 16),
                  SubTitleText(text: "분실물 이미지"),
                  SizedBox(height: 8),

                  // 선택된 이미지들 표시
                  if (selectedImages.isNotEmpty) ...[
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 120,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.gray_3),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    selectedImages[index],
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => onRemoveImage?.call(index),
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                  ],

                  // 이미지 추가 버튼 (최대 개수에 도달하지 않았을 때만 표시)
                  if (selectedImages.length < 5) ...[
                    BasicButton(
                      backgroundColor: AppColors.white,
                      onPressed: onAddImagePressed,
                      height: 120,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 32,
                              color: AppColors.gray_1,
                            ),
                            SizedBox(height: 8),
                            Text(
                              selectedImages.isEmpty
                                  ? "이미지를 추가해주세요"
                                  : "이미지 추가 (${selectedImages.length}/5)",
                              style: AppTextStyle.bodySmall(
                                color: AppColors.gray_1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: PrimaryButton(
                text: buttonText,
                onPressed: onButtonPressed,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
