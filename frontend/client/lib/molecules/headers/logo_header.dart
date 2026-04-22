import 'package:client/atoms/boxes/logo_container.dart';
import 'package:client/atoms/texts/logo_text.dart';
import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  final String logoImagePath;
  final String logoText;
  final VoidCallback? onMenuPressed;
  final EdgeInsetsGeometry? padding;

  const LogoHeader({
    super.key,
    required this.logoImagePath,
    required this.logoText,
    this.onMenuPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: 43,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                LogoContainer(imagePath: logoImagePath),
                SizedBox(width: 8),
                LogoText(text: logoText),
              ],
            ),
            IconButton(
              onPressed: onMenuPressed,
              icon: Icon(Icons.menu, size: 24),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
