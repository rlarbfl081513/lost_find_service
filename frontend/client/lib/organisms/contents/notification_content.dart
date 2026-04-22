import 'package:client/atoms/texts/sub_title_text.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/molecules/cards/reported_item_notification_card.dart';
import 'package:flutter/material.dart';

class NotificationContent extends StatelessWidget {
  const NotificationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubTitleText(
          text: "요기가 신고하신 물품과 유사한 것을 발견했어요!",
          textStyle: AppTextStyle.subTitle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemCount: 10,
          itemBuilder: (context, index) => ReportedItemNotificationCard(
            category: "지갑",
            color: "검은색",
            reportDate: "2025.07.31",
            notificationCount: 32,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
