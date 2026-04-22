import 'package:client/templates/search/item_detail_page_template.dart';
import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onPickupOptionTap() {
    print('수령 옵션 선택');
    // TODO: 수령 옵션 선택 로직 구현
  }

  void _onRequestPickup() {
    print('물건 수령 신청하기 버튼 클릭');
    // TODO: 수령 신청 로직 구현
  }

  @override
  Widget build(BuildContext context) {
    // 실제 데이터 (API에서 가져올 데이터)
    final String imagePath = 'assets/images/iphone_image.png';
    final String title = '아이폰 15 Pro Max';
    final String category = '스마트폰 > 삼성 > 제트플립';
    final String pickupInfo = '서울특별시 강남구 테헤란로 123\n2024년 1월 15일';
    final String pickupLocation = '서울특별시 강남구 분실물센터';

    final List<Map<String, dynamic>> pickupOptions = [
      {'title': '요기와 만나는 수령 스팟', 'icon': Icons.location_on},
      {'title': '전달 로봇 요기', 'icon': Icons.smart_toy},
    ];

    return ItemDetailPageTemplate(
      imagePath: imagePath,
      title: title,
      category: category,
      pickupInfo: pickupInfo,
      pickupLocation: pickupLocation,
      pickupOptions: pickupOptions,
      onBackPressed: () => _onBackPressed(context),
      onPickupOptionTap: _onPickupOptionTap,
      onRequestPickup: _onRequestPickup,
    );
  }
}
