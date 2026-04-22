import 'package:client/atoms/texts/content_text.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/molecules/lists/tag_list.dart';
import 'package:client/organisms/modals/two_button_modal.dart';
import 'package:flutter/material.dart';

class DetailItemModal extends StatelessWidget {
  final List<String> tags;
  final Widget image;
  final String infoMessage;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback onLeftButtonPressed;
  final VoidCallback onRightButtonPressed;

  const DetailItemModal({
    super.key,
    required this.tags,
    required this.image,
    required this.infoMessage,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onLeftButtonPressed,
    required this.onRightButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TwoButtonModal(
      title: "분실물 정보 확인",
      infoMessage: Container(
        alignment: Alignment.topLeft,
        child: ContentText(
          text: infoMessage,
          textStyle: AppTextStyle.subTitle(),
        ),
      ),
      guideSection: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            TagList(tags: tags, horizontalPadding: 0),
            Center(child: image),
          ],
        ),
      ),
      leftButtonText: leftButtonText,
      onLeftButtonPressed: onLeftButtonPressed,
      rightButtonText: rightButtonText,
      onRightButtonPressed: onRightButtonPressed,
    );
  }
}
