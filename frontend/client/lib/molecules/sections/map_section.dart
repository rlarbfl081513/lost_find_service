import 'package:flutter/material.dart';
import 'package:client/atoms/containers/map_container.dart';
import 'package:client/atoms/markers/map_spot.dart';
import 'package:client/atoms/markers/robot_position.dart';
import 'package:client/core/constants/app_colors.dart';

class MapSection extends StatelessWidget {
  final List<Map<String, dynamic>> spots;
  final int? selectedSpotIndex;
  final Function(int) onSpotSelected;
  final Offset robotPosition;

  const MapSection({
    super.key,
    required this.spots,
    required this.selectedSpotIndex,
    required this.onSpotSelected,
    this.robotPosition = const Offset(0.5, 0.2),
  });

  @override
  Widget build(BuildContext context) {
    return MapContainer(
      child: Stack(
        children: [
          // Map Background (임시)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.gray_3,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.map, size: 48, color: AppColors.gray_1),
            ),
          ),

          // Robot Position
          RobotPosition(position: robotPosition),

          // Spots
          ...spots.asMap().entries.map((entry) {
            final index = entry.key;
            final spot = entry.value;
            final isSelected = selectedSpotIndex == index;

            return MapSpot(
              label: spot['name'].split(' ').last,
              isSelected: isSelected,
              position: spot['position'],
              onTap: () => onSpotSelected(index),
            );
          }),
        ],
      ),
    );
  }
}
