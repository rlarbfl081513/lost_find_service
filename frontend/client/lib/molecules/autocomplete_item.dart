import 'package:client/atoms/boxes/divider_line.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class AutocompleteItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? dividerPadding;

  const AutocompleteItem({
    super.key,
    required this.text,
    this.onTap,
    this.padding,
    this.dividerPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding:
                padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.search, size: 18),
                    SizedBox(width: 10),
                    Text(text, style: AppTextStyle.regular_14()),
                  ],
                ),
                Icon(Icons.keyboard_arrow_right_rounded, size: 18),
              ],
            ),
          ),
        ),
        DividerLine(
          padding: dividerPadding ?? EdgeInsets.symmetric(horizontal: 20),
        ),
      ],
    );
  }
}
