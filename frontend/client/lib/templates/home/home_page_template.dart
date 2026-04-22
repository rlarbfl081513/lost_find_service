import 'package:client/core/constants/app_colors.dart';
import 'package:client/organisms/headers/home_header.dart';
import 'package:client/organisms/contents/home_content.dart';
import 'package:client/models/home/home_item_card_model.dart';
import 'package:flutter/material.dart';

class HomePageTemplate extends StatelessWidget {
  // Header 데이터
  final String logoImagePath;
  final String logoText;
  final String heroText;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSearchTap;

  // Content 데이터
  final List<String> categories;
  final List<HomeItemCardModel> cardData;
  final String locationText;
  final Function(String)? onCategoryTap;
  final VoidCallback? onReportPressed;

  // Background
  final String? backgroundImagePath;
  final Offset? backgroundImageOffset;
  final EdgeInsetsGeometry? padding;

  const HomePageTemplate({
    super.key,
    // Header
    required this.logoImagePath,
    required this.logoText,
    required this.heroText,
    this.onMenuPressed,
    this.onSearchTap,
    // Content
    required this.categories,
    required this.cardData,
    required this.locationText,
    this.onCategoryTap,
    this.onReportPressed,
    // Background
    this.backgroundImagePath,
    this.backgroundImageOffset,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray_2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(185),
        child: HomeHeader(
          logoImagePath: logoImagePath,
          logoText: logoText,
          heroText: heroText,
          onMenuPressed: onMenuPressed,
          onSearchTap: onSearchTap,
        ),
      ),
      body: HomeContent(
        categories: categories,
        cardData: cardData,
        locationText: locationText,
        onCategoryTap: onCategoryTap,
        onReportPressed: onReportPressed,
        backgroundImagePath: backgroundImagePath,
        backgroundImageOffset: backgroundImageOffset,
      ),
    );
  }
}
