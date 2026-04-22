import 'package:client/atoms/buttons/main_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/models/Item/item_model.dart';
import 'package:client/molecules/lists/item_list.dart';
import 'package:client/organisms/headers/search_header.dart';
import 'package:client/templates/search/item_list_page_template.dart';
import 'package:flutter/material.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  void goHome(BuildContext context) {
    Navigator.pushNamed(context, "/");
  }

  static List<ItemModel> itemList = [
    ItemModel(
      id: "1",
      name: "삼성 제트플립",
      description: "경기도 부천시 성주로 에이아파트",
      imageUrl: "assets/images/iphone_image.png",
      location: "경기도 부천시 성주로 에이아파트",
      updatedAt: "2025-03-20",
      status: "보관중",
      category: ItemCategoryModel(
        id: "1",
        name: "스마트폰",
        children: [
          ItemCategoryModel(id: "1-1", name: "삼성"),
          ItemCategoryModel(id: "1-2", name: "애플"),
        ],
      ),
    ),
    ItemModel(
      id: "2",
      name: "애플 아이폰",
      description: "경기도 부천시 성주로 에이아파트",
      imageUrl: "assets/images/iphone_image.png",
      location: "경기도 부천시 성주로 에이아파트",
      updatedAt: "2025-03-20",
      status: "보관중",
      category: ItemCategoryModel(
        id: "1",
        name: "스마트폰",
        children: [
          ItemCategoryModel(id: "1-1", name: "삼성"),
          ItemCategoryModel(id: "1-2", name: "애플"),
        ],
      ),
    ),
    ItemModel(
      id: "3",
      name: "애플 아이폰",
      description: "경기도 부천시 성주로 에이아파트",
      imageUrl: "assets/images/iphone_image.png",
      location: "경기도 부천시 성주로 에이아파트",
      updatedAt: "2025-03-20",
      status: "보관중",
      category: ItemCategoryModel(
        id: "1",
        name: "스마트폰",
        children: [
          ItemCategoryModel(id: "1-1", name: "삼성"),
          ItemCategoryModel(id: "1-2", name: "애플"),
        ],
      ),
    ),
    ItemModel(
      id: "4",
      name: "애플 아이폰",
      description: "경기도 부천시 성주로 에이아파트",
      imageUrl: "assets/images/iphone_image.png",
      location: "경기도 부천시 성주로 에이아파트",
      updatedAt: "2025-03-20",
      status: "보관중",
      category: ItemCategoryModel(
        id: "1",
        name: "스마트폰",
        children: [
          ItemCategoryModel(id: "1-1", name: "삼성"),
          ItemCategoryModel(id: "1-2", name: "애플"),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final itemsData = itemList
        .map(
          (item) => {
            'id': item.id,
            'name': item.name,
            'location': item.location,
            'updatedAt': item.updatedAt,
            'status': item.status,
            'imageUrl': item.imageUrl,
          },
        )
        .toList();

    return ItemListPageTemplate(
      searchHeader: SearchHeader(
        isEnabled: false,
        onBackPressed: () => goHome(context),
        onTap: () {
          Navigator.pushNamed(context, "/search");
        },
        onFilterPressed: () => Navigator.pushNamed(context, "/search-category"),
      ),
      itemList: ItemList(
        items: itemsData,
        onItemTap: (id) {
          // 아이템 상세 페이지로 이동
          print('아이템 상세 페이지로 이동: $id');
          Navigator.pushNamed(context, "/item-detail");
        },
      ),
      bottomSection: Container(
        decoration: BoxDecoration(),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          children: [
            Text("잃어버린 물건이 보이지 않나요?", style: AppTextStyle.bold_14()),
            SizedBox(height: 6),
            MainButton(
              borderRadius: 20,
              backgroundColor: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.share_arrival_time, size: 24),
                    Row(
                      children: [
                        Text(
                          "내가 잃어버린 물건 신고하러가기",
                          style: AppTextStyle.regular_12(),
                        ),
                        Icon(Icons.keyboard_arrow_right_outlined, size: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
