import 'package:client/atoms/badges/notification_badge.dart';
import 'package:client/atoms/buttons/basic_button.dart';
import 'package:client/atoms/texts/content_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class ReportedItemNotificationCard extends StatelessWidget {
  final String category;
  final String color;
  final String reportDate;
  final int notificationCount;
  final VoidCallback? onPressed;

  const ReportedItemNotificationCard({
    super.key,
    required this.category,
    required this.color,
    required this.reportDate,
    required this.notificationCount,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      backgroundColor: AppColors.white,
      borderRadius: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.check_circle, size: 20, color: AppColors.primary_1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  ContentText(
                    text: "$category > $color",
                    textStyle: AppTextStyle.bodyMedium(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ContentText(
                    text: "$reportDate 신고",
                    textStyle: AppTextStyle.bodySmall(),
                  ),
                ],
              ),
            ],
          ),
          NotificationBadge(count: notificationCount),
        ],
      ),
    );
  }
}
