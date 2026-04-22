import 'package:client/atoms/buttons/sub_button.dart';
import 'package:client/molecules/buttons/button_group.dart';
import 'package:client/molecules/modals/basic_modal.dart';
import 'package:flutter/material.dart';

class TwoButtonModal extends StatelessWidget {
  final String title;
  final Widget? guideSection;
  final Widget? infoMessage;
  final VoidCallback onLeftButtonPressed;
  final String leftButtonText;
  final VoidCallback onRightButtonPressed;
  final String rightButtonText;
  final bool isPrimary;
  const TwoButtonModal({
    super.key,
    required this.title,
    this.guideSection,
    this.infoMessage,
    required this.onLeftButtonPressed,
    required this.leftButtonText,
    required this.onRightButtonPressed,
    required this.rightButtonText,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return BasicModal(
      title: title,
      guideSection: guideSection,
      infoMessage: infoMessage,
      buttonSection: ButtonGroup(
        buttons: [
          SubButton(onPressed: onLeftButtonPressed, text: leftButtonText),
          SubButton(
            onPressed: onRightButtonPressed,
            text: rightButtonText,
            isPrimary: isPrimary,
          ),
        ],
      ),
    );
  }
}
