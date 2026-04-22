import 'package:client/atoms/boxes/circle_box.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/category_icons.dart';
import 'package:client/core/constants/color_palette.dart';
import 'package:client/models/Item/item_model.dart';
import 'package:client/templates/search/search_category_page_template.dart';
import 'package:flutter/material.dart';

class SearchCategoryPage extends StatefulWidget {
  const SearchCategoryPage({super.key});

  @override
  State<SearchCategoryPage> createState() => _SearchCategoryPageState();
}

class _SearchCategoryPageState extends State<SearchCategoryPage> {
  int selectedCategoryIndex = -1;
  int selectedSubCategoryIndex = -1;
  int selectedSubSubCategoryIndex = -1;
  List<int> selectedColorIndexes = [];

  // 계층 구조 카테고리 데이터
  final List<ItemCategoryModel> categories = [
    ItemCategoryModel(
      id: '1',
      name: '스마트폰',
      children: [
        ItemCategoryModel(
          id: '1-1',
          name: '삼성',
          children: [
            ItemCategoryModel(id: '1-1-1', name: 'S23 이상'),
            ItemCategoryModel(id: '1-1-2', name: 'S22 이하'),
            ItemCategoryModel(id: '1-1-3', name: 'Z플립'),
            ItemCategoryModel(id: '1-1-4', name: '기타'),
          ],
        ),
        ItemCategoryModel(
          id: '1-2',
          name: '애플',
          children: [
            ItemCategoryModel(id: '1-2-1', name: 'iPhone 15'),
            ItemCategoryModel(id: '1-2-2', name: 'iPhone 14'),
            ItemCategoryModel(id: '1-2-3', name: '기타'),
          ],
        ),
        ItemCategoryModel(id: '1-3', name: '기타', children: []),
      ],
    ),
    ItemCategoryModel(
      id: '2',
      name: '지갑',
      children: [
        ItemCategoryModel(id: '2-1', name: '가죽지갑'),
        ItemCategoryModel(id: '2-2', name: '카드지갑'),
        ItemCategoryModel(id: '2-3', name: '기타'),
      ],
    ),
    ItemCategoryModel(
      id: '3',
      name: '이어폰',
      children: [
        ItemCategoryModel(id: '3-1', name: '유선이어폰'),
        ItemCategoryModel(id: '3-2', name: '무선이어폰'),
        ItemCategoryModel(id: '3-3', name: '기타'),
      ],
    ),
    ItemCategoryModel(
      id: '4',
      name: '시계',
      children: [
        ItemCategoryModel(id: '4-1', name: '디지털시계'),
        ItemCategoryModel(id: '4-2', name: '아날로그시계'),
        ItemCategoryModel(id: '4-3', name: '스마트워치'),
        ItemCategoryModel(id: '4-4', name: '기타'),
      ],
    ),
    ItemCategoryModel(
      id: '5',
      name: '악세서리',
      children: [
        ItemCategoryModel(id: '5-1', name: '목걸이'),
        ItemCategoryModel(id: '5-2', name: '팔찌'),
        ItemCategoryModel(id: '5-3', name: '반지'),
        ItemCategoryModel(id: '5-4', name: '기타'),
      ],
    ),
    ItemCategoryModel(id: '6', name: '기타', children: []),
  ];

  // 메인 카테고리 아이콘 매핑
  final Map<String, Widget> categoryIcons = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var category in CategoryIcons().categoryIcons) {
      categoryIcons[category.koName ?? category.enName] = category.icon;
    }
  }

  final List<Map<String, dynamic>> colors = ColorPalette().colorList.map((
    color,
  ) {
    return {
      'text': color.koName,
      'icon': Icon(Icons.circle, color: Color(color.colorCode), size: 30),
    };
  }).toList();

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void onCategoryTap(int index) {
    setState(() {
      if (selectedCategoryIndex == index) {
        selectedCategoryIndex = -1;
        selectedSubCategoryIndex = -1;
        selectedSubSubCategoryIndex = -1;
      } else {
        selectedCategoryIndex = index;
        selectedSubCategoryIndex = -1;
        selectedSubSubCategoryIndex = -1;
      }
    });
  }

  void onSubCategoryTap(int index) {
    setState(() {
      if (selectedSubCategoryIndex == index) {
        selectedSubCategoryIndex = -1;
        selectedSubSubCategoryIndex = -1;
      } else {
        selectedSubCategoryIndex = index;
        selectedSubSubCategoryIndex = -1;
      }
    });
  }

  void onSubSubCategoryTap(int index) {
    setState(() {
      selectedSubSubCategoryIndex = selectedSubSubCategoryIndex == index
          ? -1
          : index;
    });
  }

  void onColorTap(int index) {
    setState(() {
      if (selectedColorIndexes.contains(index)) {
        selectedColorIndexes.remove(index);
      } else {
        selectedColorIndexes.add(index);
      }
    });
  }

  void onButtonPressed() {
    print('분실물 보기 버튼 클릭');

    String selectedCategory = selectedCategoryIndex >= 0
        ? categories[selectedCategoryIndex].name
        : '없음';

    String selectedSubCategory =
        selectedCategoryIndex >= 0 && selectedSubCategoryIndex >= 0
        ? categories[selectedCategoryIndex]
              .children[selectedSubCategoryIndex]
              .name
        : '없음';

    String selectedSubSubCategory =
        selectedCategoryIndex >= 0 &&
            selectedSubCategoryIndex >= 0 &&
            selectedSubSubCategoryIndex >= 0
        ? categories[selectedCategoryIndex]
              .children[selectedSubCategoryIndex]
              .children[selectedSubSubCategoryIndex]
              .name
        : '없음';

    print('선택된 카테고리: $selectedCategory');
    print('선택된 서브 카테고리: $selectedSubCategory');
    print('선택된 서브 서브 카테고리: $selectedSubSubCategory');
    print(
      '선택된 색상: ${selectedColorIndexes.isNotEmpty ? selectedColorIndexes.map((i) => colors[i]['text']).join(', ') : '없음'}',
    );
  }

  @override
  Widget build(BuildContext context) {
    // 메인 카테고리 데이터 변환
    final List<Map<String, dynamic>> mainCategories = categories.map((
      category,
    ) {
      return {
        'icon': categoryIcons[category.name],
        'text': category.name,
        'category': category,
      };
    }).toList();

    return SearchCategoryPageTemplate(
      headerTitle: "카테고리",
      onBackPressed: () => goBack(context),
      categories: mainCategories,
      colors: colors,
      selectedCategoryIndex: selectedCategoryIndex,
      selectedSubCategoryIndex: selectedSubCategoryIndex,
      selectedSubSubCategoryIndex: selectedSubSubCategoryIndex,
      selectedColorIndexes: selectedColorIndexes,
      onCategoryTap: onCategoryTap,
      onSubCategoryTap: onSubCategoryTap,
      onSubSubCategoryTap: onSubSubCategoryTap,
      onColorTap: onColorTap,
      itemCount: 25,
      buttonText: "분실물 보기",
      onButtonPressed: onButtonPressed,
    );
  }
}
