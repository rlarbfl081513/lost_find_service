import 'package:flutter/material.dart';

class ButtonGroup extends StatelessWidget {
  final List<Widget> buttons;
  final double spacing;
  const ButtonGroup({super.key, required this.buttons, this.spacing = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: spacing,
      children: buttons.map((button) {
        return Expanded(child: button);
      }).toList(),
    );
  }
}
