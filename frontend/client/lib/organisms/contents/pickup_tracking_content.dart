import 'package:client/atoms/buttons/sub_button.dart';
import 'package:client/molecules/buttons/button_group.dart';
import 'package:flutter/material.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/atoms/boxes/divider_line.dart';
import 'package:client/atoms/buttons/primary_button.dart';

class PickupTrackingContent extends StatelessWidget {
  final String estimatedTime; // 예상 소요시간 (분)
  final double progress; // 진행률 (0.0 ~ 1.0)
  final String robotLocation; // 요기 위치 (주소)
  final String itemName; // 분실물 이름
  final VoidCallback? onPickupCompleted;
  final VoidCallback? onPickupCancelled;
  final VoidCallback? onSpotChanged;
  final EdgeInsetsGeometry? padding;

  const PickupTrackingContent({
    super.key,
    required this.estimatedTime,
    required this.progress,
    required this.robotLocation,
    required this.itemName,
    this.onPickupCompleted,
    this.onPickupCancelled,
    this.onSpotChanged,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("요기가 가고있어요", style: AppTextStyle.title()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("소요시간", style: AppTextStyle.bodySmall()),
                  Text("$estimatedTime분", style: AppTextStyle.title()),
                ],
              ),
            ],
          ),

          SizedBox(height: 20),

          // 2. 게이지 바
          _buildProgressGauge(),

          SizedBox(height: 20),

          // 3. 정보 Section
          _buildInfoSection(),

          // 4. 라인
          DividerLine(padding: EdgeInsets.symmetric(vertical: 16)),

          // 5. 안내문구
          Center(
            child: Text(
              "요기와 만났다면 아래 버튼을 눌러\n물건을 수령하세요!",
              style: AppTextStyle.bodySmall(color: AppColors.gray_1),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 6),

          // 6. 수령 신청 버튼
          PrimaryButton(
            text: "물건 수령 신청하기",
            onPressed: onPickupCompleted,
            backgroundColor: AppColors.primary_1,
            textColor: AppColors.white,
          ),

          // 7. 라인
          DividerLine(padding: EdgeInsets.symmetric(vertical: 16)),

          // 8. 서브 버튼 두개
          ButtonGroup(
            buttons: [
              SubButton(onPressed: onPickupCancelled, text: "수령 취소하기"),
              SubButton(onPressed: onSpotChanged, text: "스팟 바꾸기"),
            ],
          ),
        ],
      ),
    );
  }

  // 게이지 바 위젯
  Widget _buildProgressGauge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.gray_2,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 배경 바
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.gray_1,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // 진행 바
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 200 * progress, // 고정 너비 사용
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.primary_1,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // 요기 캐릭터 (게이지에 따라 움직임)
              Positioned(
                left: (200 * progress) - 60, // 고정 너비 사용
                top: -65,
                child: Transform.scale(
                  scaleX: -1,
                  child: Image.asset('assets/images/yogi.png', width: 55),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "요기이동중",
              style: AppTextStyle.regular_12(color: AppColors.gray_1),
            ),
            Text(
              "스팟도착",
              style: AppTextStyle.regular_12(color: AppColors.gray_1),
            ),
          ],
        ),
      ],
    );
  }

  // 정보 섹션 위젯
  Widget _buildInfoSection() {
    return Column(
      children: [
        // 요기 위치
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Text(
                "요기위치",
                style: AppTextStyle.bodyMedium(fontWeight: FontWeight.normal),
              ),
            ),
            Expanded(
              child: Text(
                robotLocation,
                textAlign: TextAlign.end,
                style: AppTextStyle.bodyMedium(),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        // 분실물 정보
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                "분실물 정보",
                style: AppTextStyle.bodyMedium(fontWeight: FontWeight.normal),
              ),
            ),
            Expanded(
              child: Text(
                itemName,
                textAlign: TextAlign.end,
                style: AppTextStyle.bodyMedium(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
