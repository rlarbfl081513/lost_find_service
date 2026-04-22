import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class LocationHeader extends StatelessWidget {
  final String locationText;
  final EdgeInsetsGeometry? padding;

  const LocationHeader({super.key, required this.locationText, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.location_on, size: 24),
          Text(locationText, style: AppTextStyle.bold_12()),
        ],
      ),
    );
  }
}
