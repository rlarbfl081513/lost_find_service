import 'package:flutter/material.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';

class SpotInfoSection extends StatelessWidget {
  final String? spotName;
  final String? address;
  final int? time;
  final String emptyMessage;

  const SpotInfoSection({
    super.key,
    this.spotName,
    this.address,
    this.time,
    this.emptyMessage = "스팟을 선택하여\n요기와 만날 장소를 정하세요.",
  });

  @override
  Widget build(BuildContext context) {
    if (spotName == null || address == null || time == null) {
      return Text(
        emptyMessage,
        style: AppTextStyle.regular_20(color: AppColors.black),
        textAlign: TextAlign.center,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "요기 위치",
              style: AppTextStyle.regular_14(color: AppColors.black),
            ),
            Expanded(
              child: Text(
                address!,
                style: AppTextStyle.bold_16(),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "수령 소요 시간",
              style: AppTextStyle.regular_14(color: AppColors.black),
            ),
            Text("$time분", style: AppTextStyle.bold_16()),
          ],
        ),
      ],
    );
  }
}
