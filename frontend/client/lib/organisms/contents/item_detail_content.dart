import 'package:client/atoms/boxes/divider_line.dart';
import 'package:client/atoms/buttons/primary_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:client/molecules/sections/item_info_section.dart';
import 'package:client/molecules/cards/pickup_location_card.dart';
import 'package:flutter/material.dart';

class ItemDetailContent extends StatelessWidget {
  final String title;
  final String category;
  final String pickupInfo;
  final String pickupLocation;
  final List<Map<String, dynamic>> pickupOptions;
  final VoidCallback? onPickupOptionTap;
  final VoidCallback? onRequestPickup;

  const ItemDetailContent({
    super.key,
    required this.title,
    required this.category,
    required this.pickupInfo,
    required this.pickupLocation,
    required this.pickupOptions,
    this.onPickupOptionTap,
    this.onRequestPickup,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          Text(title, style: AppTextStyle.bold_20(color: AppColors.black)),
          const SizedBox(height: 20),

          // 카테고리
          ItemInfoSection(title: '카테고리', content: category),
          const SizedBox(height: 20),

          // 습득 정보
          ItemInfoSection(title: '습득 정보', content: pickupInfo),

          DividerLine(
            padding: const EdgeInsets.symmetric(vertical: 20),
            height: 1,
            color: withOpacityValue(AppColors.gray_1, 0.2),
          ),

          // 수령 정보
          Text("수령 정보", style: AppTextStyle.bold_12(color: AppColors.black)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: pickupOptions.map((option) {
              return PickupLocationCard(
                title: option['title'],
                icon: option['icon'],
                onTap: onPickupOptionTap != null
                    ? () => onPickupOptionTap!()
                    : null,
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // 지도 (임시로 컨테이너로 표시)
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.gray_2,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gray_1),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 48, color: AppColors.gray_1),
                  SizedBox(height: 8),
                  Text(
                    '지도 영역',
                    style: TextStyle(color: AppColors.gray_1, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          // 수령 신청 버튼
          PrimaryButton(text: '물건 수령 신청하기', onPressed: onRequestPickup),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
