import 'package:client/organisms/contents/pickup_tracking_content.dart';
import 'package:client/organisms/maps/pickup_tracking_map.dart';
import 'package:client/templates/common/draggable_bottom_sheet_template.dart';
import 'package:flutter/material.dart';

class PickupTrackingPageTemplate extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onPickupCompleted;
  final VoidCallback? onPickupCancelled;
  final VoidCallback? onSpotChanged;
  final Offset robotPosition;
  final Offset spotPosition;
  final double progress;
  final double scale;
  final VoidCallback? onMapTap;
  final String estimatedTime;
  final String robotLocation;
  final String itemName;

  const PickupTrackingPageTemplate({
    super.key,
    this.onBackPressed,
    this.onPickupCompleted,
    this.onPickupCancelled,
    this.onSpotChanged,
    required this.robotPosition,
    required this.spotPosition,
    required this.progress,
    required this.scale,
    this.onMapTap,
    required this.estimatedTime,
    required this.robotLocation,
    required this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheetTemplate(
      backGroundWidget: PickupTrackingMap(
        robotPosition: robotPosition,
        spotPosition: spotPosition,
        progress: progress,
        scale: scale,
        onMapTap: onMapTap,
      ),
      body: PickupTrackingContent(
        estimatedTime: estimatedTime, // 예상 소요시간 (분)
        progress: progress,
        robotLocation: robotLocation, // 요기 위치
        itemName: itemName, // 분실물 이름
        onPickupCompleted: onPickupCompleted,
        onPickupCancelled: onPickupCancelled,
        onSpotChanged: onSpotChanged,
      ),
      onBackPressed: onBackPressed,
    );
  }
}
