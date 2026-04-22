import 'package:client/organisms/contents/item_detail_content.dart';
import 'package:client/templates/common/draggable_bottom_sheet_template.dart';
import 'package:flutter/material.dart';

class ItemDetailPageTemplate extends StatelessWidget {
  final String imagePath;
  final String title;
  final String category;
  final String pickupInfo;
  final String pickupLocation;
  final List<Map<String, dynamic>> pickupOptions;
  final VoidCallback? onBackPressed;
  final VoidCallback? onPickupOptionTap;
  final VoidCallback? onRequestPickup;

  const ItemDetailPageTemplate({
    super.key,
    required this.imagePath,
    required this.title,
    required this.category,
    required this.pickupInfo,
    required this.pickupLocation,
    required this.pickupOptions,
    this.onBackPressed,
    this.onPickupOptionTap,
    this.onRequestPickup,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheetTemplate(
      backGroundWidget: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
      onBackPressed: onBackPressed,
      body: ItemDetailContent(
        title: title,
        category: category,
        pickupInfo: pickupInfo,
        pickupLocation: pickupLocation,
        pickupOptions: pickupOptions,
        onPickupOptionTap: onPickupOptionTap,
        onRequestPickup: onRequestPickup,
      ),
    );
  }
}
