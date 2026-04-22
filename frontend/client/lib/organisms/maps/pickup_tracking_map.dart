import 'package:flutter/material.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/atoms/markers/map_spot.dart';
import 'package:client/atoms/markers/robot_position.dart';

class PickupTrackingMap extends StatelessWidget {
  final Offset robotPosition;
  final Offset spotPosition;
  final double progress; // 0.0 ~ 1.0
  final double scale; // 드래그에 따른 크기 변화
  final VoidCallback? onMapTap;

  const PickupTrackingMap({
    super.key,
    required this.robotPosition,
    required this.spotPosition,
    this.progress = 0.0,
    this.scale = 1.0,
    this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMapTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.gray_3,
          image: DecorationImage(
            image: AssetImage('assets/images/map_background.png'), // 임의의 지도 이미지
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // 연결선 (로봇과 스팟 사이)
            CustomPaint(
              size: Size.infinite,
              painter: ConnectionLinePainter(
                robotPosition: robotPosition,
                spotPosition: spotPosition,
                progress: progress,
              ),
            ),

            // 스팟 위치 (목적지)
            MapSpot(label: "스팟", isSelected: true, position: spotPosition),

            // 로봇 위치 (현재 위치)
            RobotPosition(position: robotPosition),

            // 진행률에 따른 로봇 위치 (게이지와 연동)
            Positioned(
              left:
                  robotPosition.dx +
                  (spotPosition.dx - robotPosition.dx) * progress,
              top:
                  robotPosition.dy +
                  (spotPosition.dy - robotPosition.dy) * progress,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.primary_1,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.smart_toy,
                    size: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 연결선을 그리는 CustomPainter
class ConnectionLinePainter extends CustomPainter {
  final Offset robotPosition;
  final Offset spotPosition;
  final double progress;

  ConnectionLinePainter({
    required this.robotPosition,
    required this.spotPosition,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary_1
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // 점선 효과를 위한 대시 설정
    paint.style = PaintingStyle.stroke;

    // 진행률에 따른 현재 위치 계산
    final currentPosition = Offset(
      robotPosition.dx + (spotPosition.dx - robotPosition.dx) * progress,
      robotPosition.dy + (spotPosition.dy - robotPosition.dy) * progress,
    );

    // 로봇에서 현재 위치까지의 선 (완료된 부분)
    canvas.drawLine(robotPosition, currentPosition, paint);

    // 현재 위치에서 스팟까지의 선 (미완료 부분, 점선)
    final dashPaint = Paint()
      ..color = AppColors.gray_1
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // 점선 그리기 (간단한 방법)
    final distance = (spotPosition - currentPosition).distance;
    final dashLength = 8.0;
    final dashSpace = 4.0;
    final totalDashLength = dashLength + dashSpace;

    final direction = (spotPosition - currentPosition) / distance;

    for (double i = 0; i < distance; i += totalDashLength) {
      final start = currentPosition + direction * i;
      final end =
          currentPosition + direction * (i + dashLength).clamp(0.0, distance);
      canvas.drawLine(start, end, dashPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
