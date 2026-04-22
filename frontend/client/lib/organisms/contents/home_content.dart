import 'package:client/core/constants/app_text_style.dart';
import 'package:client/molecules/lists/category_quick_access.dart';
import 'package:client/molecules/headers/location_header.dart';
import 'package:client/molecules/buttons/report_button.dart';
import 'package:client/molecules/lists/home_item_card_list.dart';
import 'package:client/models/home/home_item_card_model.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final List<String> categories;
  final List<HomeItemCardModel> cardData;
  final String locationText;
  final Function(String)? onCategoryTap;
  final VoidCallback? onReportPressed;
  final String? backgroundImagePath;
  final Offset? backgroundImageOffset;
  final EdgeInsetsGeometry? padding;

  const HomeContent({
    super.key,
    required this.categories,
    required this.cardData,
    required this.locationText,
    this.onCategoryTap,
    this.onReportPressed,
    this.backgroundImagePath,
    this.backgroundImageOffset,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 카테고리 리스트를 Stack의 자식으로 배치
        Positioned(
          left: 0,
          right: 0,
          top: 50 + 24, // SizedBox + AppBar 등 고려해서 위치 조정
          child: CategoryQuickAccess(
            categories: categories,
            onCategoryTap: onCategoryTap,
          ),
        ),
        // 메인 콘텐츠
        Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text("카테고리 바로가기", style: AppTextStyle.bold_12()),
              SizedBox(height: 83), // ListView가 들어갈 자리만큼 공간 확보
              SizedBox(height: 20),
              LocationHeader(locationText: locationText),
              SizedBox(height: 6),
              HomeItemCardList(cardData: cardData),
              SizedBox(height: 65),
              // 하단 신고 버튼
              ReportButton(
                title: "내가 잃어버린 물건 신고하러가기",
                onPressed: onReportPressed,
                backgroundImagePath: backgroundImagePath,
                backgroundImageOffset: backgroundImageOffset,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
