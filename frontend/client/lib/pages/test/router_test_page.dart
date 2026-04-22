import 'package:client/atoms/buttons/primary_button.dart';
import 'package:client/molecules/buttons/report_button.dart';
import 'package:flutter/material.dart';
import 'package:client/routes/app_routes.dart';
import 'package:client/atoms/buttons/main_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';

class RouterTestPage extends StatelessWidget {
  const RouterTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('라우터 테스트', style: AppTextStyle.bold_20()),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryButton(text: '테스트 버튼', onPressed: () {}),

            ReportButton(
              title: '내가 잃어버린 물건 신고하러 가기',
              onPressed: () {},
              backgroundImagePath: 'assets/images/yogi.png',
              backgroundImageOffset: Offset(27, -35),
            ),

            // 제목
            Text('페이지 라우터 테스트', style: AppTextStyle.bold_24()),
            const SizedBox(height: 8),
            Text(
              '각 버튼을 눌러 해당 페이지로 이동할 수 있습니다.',
              style: AppTextStyle.regular_14(color: AppColors.gray_1),
            ),
            const SizedBox(height: 32),

            // 라우터 버튼들
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: AppRoutes.routes.map((route) {
                    // 라우트 이름을 보기 좋게 표시
                    String displayName = _getDisplayName(route.path);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: MainButton(
                        width: double.infinity,
                        height: 56,
                        backgroundColor: AppColors.primary_1,
                        onPressed: () {
                          Navigator.pushNamed(context, route.path);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              displayName,
                              style: AppTextStyle.bold_16(
                                color: AppColors.black,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  route.path,
                                  style: AppTextStyle.regular_12(
                                    color: AppColors.gray_1,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: AppColors.gray_1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // 추가 정보
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.gray_3,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('테스트 정보', style: AppTextStyle.bold_14()),
                  const SizedBox(height: 8),
                  Text(
                    '• 총 ${AppRoutes.routes.length}개의 라우터가 등록되어 있습니다.\n'
                    '• 각 페이지는 독립적으로 테스트할 수 있습니다.\n'
                    '• 뒤로가기 버튼으로 이 페이지로 돌아올 수 있습니다.',
                    style: AppTextStyle.regular_12(color: AppColors.gray_1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 라우트 경로를 보기 좋은 이름으로 변환
  String _getDisplayName(String path) {
    switch (path) {
      case '/':
        return '🏠 홈 페이지';
      case '/search':
        return '🔍 검색 페이지';
      case '/item-list':
        return '📋 아이템 목록 페이지';
      case '/item-detail':
        return '📄 아이템 상세 페이지';
      case '/search-category':
        return '📂 카테고리 검색 페이지';
      case '/autocomplete-test':
        return '🔤 자동완성 테스트 페이지';
      case '/pickup':
        return '🤖 수령하기 페이지';
      case '/api-test':
        return '🔗 API 연결 테스트 페이지';
      default:
        return path;
    }
  }
}
