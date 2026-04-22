import 'dart:io';
import 'package:client/organisms/modals/detail_item_modal.dart';
import 'package:flutter/material.dart';
import 'package:client/core/constants/category_icons.dart';
import 'package:client/core/constants/color_palette.dart';
import 'package:client/core/utils/select_image_utils.dart';
import 'package:client/models/Item/item_model.dart';
import 'package:client/organisms/modals/select_image_modal.dart';
import 'package:client/templates/user/item_report_template.dart';

class ItemReportPage extends StatefulWidget {
  const ItemReportPage({super.key});

  @override
  State<ItemReportPage> createState() => _ItemReportPageState();
}

class _ItemReportPageState extends State<ItemReportPage> {
  int selectedCategoryIndex = -1;
  int selectedSubCategoryIndex = -1;
  int selectedSubSubCategoryIndex = -1;
  List<int> selectedColorIndexes = [];
  late TextEditingController descriptionController;

  // 이미지 관련 상태
  List<File> selectedImages = [];
  final int maxImageCount = 1; // 최대 이미지 개수
  String description = '';

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
    super.initState();
    for (var category in CategoryIcons().categoryIcons) {
      categoryIcons[category.koName ?? category.enName] = category.icon;
    }
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
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

    List<String> tags = [];
    if (selectedCategory != '없음') {
      tags.add(selectedCategory);
    }
    if (selectedSubCategory != '없음') {
      tags.add(selectedSubCategory);
    }
    if (selectedSubSubCategory != '없음') {
      tags.add(selectedSubSubCategory);
    }

    showDialog(
      context: context,
      builder: (context) => DetailItemModal(
        tags: tags,
        image: Image.asset("assets/images/yogi.png"),
        infoMessage: description,
        leftButtonText: "수정하기",
        rightButtonText: "완료하기",
        onLeftButtonPressed: () {},
        onRightButtonPressed: () {},
      ),
    );

    print('선택된 카테고리: $selectedCategory');
    print('선택된 서브 카테고리: $selectedSubCategory');
    print('선택된 서브 서브 카테고리: $selectedSubSubCategory');
    print(
      '선택된 색상: ${selectedColorIndexes.isNotEmpty ? selectedColorIndexes.map((i) => colors[i]['text']).join(', ') : '없음'}',
    );
    print('선택된 이미지 개수: ${selectedImages.length}');
    for (int i = 0; i < selectedImages.length; i++) {
      print('이미지 ${i + 1}: ${selectedImages[i].path}');
    }
  }

  void onAddImagePressed() async {
    print('이미지 추가 버튼 클릭');

    // 최대 이미지 개수 체크
    if (selectedImages.length >= maxImageCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미지는 최대 $maxImageCount개까지 추가할 수 있습니다.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 이미지 선택 옵션 다이얼로그 표시
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SelectImageModal(
          onPickImagesFromGallery: _pickImagesFromGallery,
          onTakePhotoWithCamera: _takePhotoWithCamera,
        );
      },
    );
  }

  // 갤러리에서 이미지 선택
  Future<void> _pickImagesFromGallery() async {
    final imageUtils = SelectImageUtils(
      context: context,
      maxImageCount: maxImageCount - selectedImages.length,
    );

    List<File> newImages = await imageUtils.pickImagesFromGallery();

    if (newImages.isNotEmpty) {
      setState(() {
        selectedImages.addAll(newImages);
      });
    }
  }

  // 카메라로 사진 촬영
  Future<void> _takePhotoWithCamera() async {
    final imageUtils = SelectImageUtils(
      context: context,
      maxImageCount: maxImageCount - selectedImages.length,
    );

    List<File> newImages = await imageUtils.takePhotoWithCamera();

    if (newImages.isNotEmpty) {
      setState(() {
        selectedImages.addAll(newImages);
      });
    }
  }

  // 이미지 삭제
  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
    print('이미지 삭제됨: $index');
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mainCategories = categories.map((
      category,
    ) {
      return {
        'icon': categoryIcons[category.name],
        'text': category.name,
        'category': category,
      };
    }).toList();
    return ItemReportTemplate(
      headerTitle: "내 분실물 신고하기",
      onBackPressed: () {
        Navigator.pop(context);
      },
      categories: mainCategories,
      colors: colors,
      selectedCategoryIndex: selectedCategoryIndex,
      selectedSubCategoryIndex: selectedSubCategoryIndex,
      selectedSubSubCategoryIndex: selectedSubSubCategoryIndex,
      selectedColorIndexes: selectedColorIndexes,
      onCategoryTap: (index) => onCategoryTap(index),
      onSubCategoryTap: (index) => onSubCategoryTap(index),
      onSubSubCategoryTap: (index) => onSubSubCategoryTap(index),
      onColorTap: (index) => onColorTap(index),
      onAddImagePressed: () => onAddImagePressed(),
      descriptionController: descriptionController,
      onDescriptionChanged: (value) {
        setState(() {
          description = value;
          descriptionController.text = value;
        });
      },
      selectedImages: selectedImages,
      onRemoveImage: (index) => _removeImage(index),
      buttonText: "내 분실물 신고하기",
      onButtonPressed: () => onButtonPressed(),
    );
  }
}
