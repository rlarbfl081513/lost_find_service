import 'package:client/templates/common/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:client/molecules/sections/map_section.dart';
import 'package:client/molecules/sections/spot_info_section.dart';
import 'package:client/atoms/buttons/main_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';

class PickupSelectTemplate extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Map<String, dynamic>> spots;
  final int? selectedSpotIndex;
  final Function(int) onSpotSelected;
  final VoidCallback? onConfirmPressed;
  final String confirmButtonText;

  const PickupSelectTemplate({
    super.key,
    required this.title,
    this.onBackPressed,
    required this.spots,
    required this.selectedSpotIndex,
    required this.onSpotSelected,
    this.onConfirmPressed,
    this.confirmButtonText = "요기와 만나기",
  });

  @override
  Widget build(BuildContext context) {
    final selectedSpot = selectedSpotIndex != null
        ? spots[selectedSpotIndex!]
        : null;

    return BasicTemplate(
      title: title,
      onBackPressed: onBackPressed,
      body: Column(
        children: [
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // Map Section
                  Expanded(
                    flex: 2,
                    child: MapSection(
                      spots: spots,
                      selectedSpotIndex: selectedSpotIndex,
                      onSpotSelected: onSpotSelected,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Text Section
                  Expanded(
                    flex: 1,
                    child: SpotInfoSection(
                      spotName: selectedSpot?['name'],
                      address: selectedSpot?['address'],
                      time: selectedSpot?['time'],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Bottom Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: MainButton(
              width: double.infinity,
              borderRadius: 14,
              height: 56,
              backgroundColor: selectedSpotIndex != null
                  ? AppColors.primary_1
                  : AppColors.white,
              onPressed: selectedSpotIndex != null ? onConfirmPressed : null,
              child: Text(
                confirmButtonText,
                style: AppTextStyle.bold_16(
                  color: selectedSpotIndex != null
                      ? AppColors.black
                      : AppColors.gray_1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
