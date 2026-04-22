import 'package:flutter/material.dart';

class TrapezoidPainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double width;
  final double height;
  final double? topPadding;
  final double? bottomPadding;
  final bool isRightShort;
  final double borderRadius;

  TrapezoidPainter({
    required this.color,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
    required this.width,
    required this.height,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.isRightShort = true,
    this.borderRadius = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // width를 고정하고 leftHeight, rightHeight로 사다리꼴 그리기
    if (isRightShort) {
      // 왼쪽 위 꼭지점
      path.moveTo(0, 0);
      // 오른쪽 위 꼭지점
      path.lineTo(width, topPadding ?? 0);
      // 오른쪽 아래 꼭지점
      path.lineTo(width, height - (bottomPadding ?? 0));
      // 왼쪽 아래 꼭지점
      path.lineTo(0, height);
      path.close();
    } else {
      // 왼쪽 위 꼭지점
      path.moveTo(0, topPadding ?? 0);
      // 오른쪽 위 꼭지점
      path.lineTo(width, 0);
      // 오른쪽 아래 꼭지점
      path.lineTo(width, height);
      // 왼쪽 아래 꼭지점
      path.lineTo(0, height - (bottomPadding ?? 0));
      path.close();
    }

    // borderRadius가 0보다 크면 각 모서리별로 둥근 모서리 적용
    if (borderRadius > 0) {
      final roundedPath = Path();

      if (isRightShort) {
        // 왼쪽이 긴 사다리꼴: 각 모서리별로 radius 적용
        // 왼쪽 위 모서리
        roundedPath.moveTo(borderRadius, 0);
        roundedPath.lineTo(width - borderRadius, topPadding ?? 0);
        // 오른쪽 위 모서리
        roundedPath.arcToPoint(
          Offset(width, (topPadding ?? 0) + borderRadius),
          radius: Radius.circular(borderRadius),
          clockwise: true,
        );
        // 오른쪽 아래 모서리
        roundedPath.lineTo(width, height - (bottomPadding ?? 0) - borderRadius);
        roundedPath.arcToPoint(
          Offset(width - borderRadius, height - (bottomPadding ?? 0)),
          radius: Radius.circular(borderRadius),
          clockwise: true,
        );
        // 왼쪽 아래 모서리
        roundedPath.lineTo(borderRadius, height);
        roundedPath.arcToPoint(
          Offset(0, height - borderRadius),
          radius: Radius.circular(borderRadius),
          clockwise: true,
        );
        // 왼쪽 위 모서리
        roundedPath.lineTo(0, borderRadius);
        roundedPath.arcToPoint(
          Offset(borderRadius, 0),
          radius: Radius.circular(borderRadius),
          clockwise: true,
        );
      } else {
        // 오른쪽이 긴 사다리꼴: 각 모서리별로 radius 적용
        // 왼쪽 위 모서리
        roundedPath.moveTo(borderRadius, topPadding ?? 0);
        roundedPath.lineTo(width - borderRadius, 0);
        // 오른쪽 위 모서리
        roundedPath.arcToPoint(
          Offset(width, borderRadius),
          radius: Radius.circular(borderRadius),
          clockwise: true,
        );
        // 오른쪽 아래 모서리
        roundedPath.lineTo(width, height - borderRadius);
        roundedPath.arcToPoint(
          Offset(width - borderRadius, height),
          radius: Radius.circular(borderRadius),
          clockwise: true,
        );
        // 왼쪽 아래 모서리
        roundedPath.lineTo(borderRadius, height - (bottomPadding ?? 0));
        roundedPath.arcToPoint(
          Offset(0, height - (bottomPadding ?? 0) - borderRadius),
          radius: Radius.circular(borderRadius),
          clockwise: true,
        );
        // 왼쪽 위 모서리
        roundedPath.lineTo(0, (topPadding ?? 0) + borderRadius);
        roundedPath.arcToPoint(
          Offset(borderRadius, topPadding ?? 0),
          radius: Radius.circular(borderRadius),
          clockwise: true,
        );
      }

      roundedPath.close();

      // 배경 그리기
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill
        ..isAntiAlias = true; // 안티앨리어싱 활성화
      canvas.drawPath(roundedPath, paint);

      // 테두리 그리기
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..isAntiAlias = true; // 안티앨리어싱 활성화

      canvas.drawPath(roundedPath, borderPaint);
    } else {
      // borderRadius가 0이면 기존 방식으로 그리기
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill
        ..isAntiAlias = true; // 안티앨리어싱 활성화
      canvas.drawPath(path, paint);

      // 테두리 그리기
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..isAntiAlias = true; // 안티앨리어싱 활성화

      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
