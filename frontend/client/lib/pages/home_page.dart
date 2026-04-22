import 'package:client/models/home/home_item_card_model.dart';
import 'package:client/templates/home/home_page_template.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 데이터 상태
  late List<HomeItemCardModel> cardData;
  late List<String> categories;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // 데이터 초기화
  void _initializeData() {
    cardData = [
      HomeItemCardModel(
        imageUrl: "assets/images/iphone_image.png",
        date: "2025-02-25",
        category: "iphone",
      ),
      HomeItemCardModel(
        imageUrl: "https://picsum.photos/200/300",
        date: "2025-01-01",
        category: "카테고리",
      ),
      HomeItemCardModel(
        imageUrl: "https://picsum.photos/200/300",
        date: "2025-01-01",
        category: "카테고리",
      ),
    ];

    categories = ["스마트폰", "지갑", "이어폰", "시계", "악세서리", "기타"];
  }

  // 이벤트 핸들러들
  void _onSearchTap() {
    FocusScope.of(context).unfocus();
    Navigator.pushNamed(context, "/search");
  }

  void _onCategoryTap(String category) {
    // 카테고리 선택 액션
    print('카테고리 선택: $category');
    // TODO: 카테고리별 필터링 로직 구현
  }

  void _onReportPressed() {
    // 신고 버튼 액션
    print('신고 버튼 클릭');
    // TODO: 신고 페이지로 이동 로직 구현
  }

  // 데이터 새로고침 (필요시)
  void _refreshData() {
    setState(() {
      _initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePageTemplate(
      // Header 데이터
      logoImagePath: "assets/images/yogi.png",
      logoText: "여기 있잖아",
      heroText: '요기와 함께\n잃어버린 물건을 찾으세요!',
      onSearchTap: _onSearchTap,

      // Content 데이터
      categories: categories,
      cardData: cardData,
      locationText: "강남구 역삼동 주변 최신 분실물",
      onCategoryTap: _onCategoryTap,
      onReportPressed: _onReportPressed,

      // Background 데이터 - ReportButton 뒤쪽에 위치하도록 오프셋 설정
      backgroundImagePath: "assets/images/dot_yogi.png",
      backgroundImageOffset: const Offset(-38, -34), // ReportButton 뒤쪽에 겹치도록 조정
    );
  }
}
