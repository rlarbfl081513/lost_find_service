import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SpeechBubble extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final double? triangleWidth;
  final double? triangleHeight;
  final EdgeInsets? padding;

  const SpeechBubble({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 10,
    this.borderWidth = 0,
    this.triangleWidth = 18,
    this.triangleHeight = 15,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // 삼각형이 잘리지 않도록
      children: [
        // 메인 말풍선 박스
        Container(
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.white,
            borderRadius: BorderRadius.circular(borderRadius!),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth!,
            ),
          ),
          child: child,
        ),
        // 삼각형 말풍선 꼬리
        Positioned(
          bottom: -triangleHeight!,
          left: 20, // 왼쪽에서 20픽셀 떨어진 위치
          child: CustomPaint(
            size: Size(triangleWidth!, triangleHeight!),
            painter: TrianglePainter(
              color: backgroundColor ?? AppColors.white,
              borderColor: borderColor,
              borderWidth: borderWidth!,
            ),
          ),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final Color? borderColor;
  final double borderWidth;

  TrianglePainter({
    required this.color,
    this.borderColor,
    this.borderWidth = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    // 역삼각형 (아래쪽이 뾰족한 부분)
    path.moveTo(size.width * 0.3, 0); // 왼쪽 위 (기울어진 부분)
    path.lineTo(0, size.height); // 아래쪽 뾰족한 부분
    path.lineTo(size.width, 0); // 오른쪽 위
    path.close();

    canvas.drawPath(path, paint);

    // 테두리가 있는 경우
    if (borderWidth > 0 && borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;

      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
