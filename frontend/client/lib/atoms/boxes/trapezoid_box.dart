import 'package:client/atoms/painters/trapezoid_painter.dart';
import 'package:flutter/material.dart';

class TrapezoidBox extends StatelessWidget {
  /// 사다리꼴 박스의 배경색을 지정합니다.
  final Color color;

  /// 사다리꼴 박스의 테두리 색상을 지정합니다.
  final Color borderColor;

  /// 사다리꼴 박스의 테두리 두께를 지정합니다.
  final double borderWidth;

  /// 사다리꼴 박스의 가로 길이를 지정합니다.
  final double width;

  /// 사다리꼴 박스의 세로 길이를 지정합니다.
  final double height;

  /// 사다리꼴 박스의 위쪽 패딩을 지정합니다.
  final double? topPadding;

  /// 사다리꼴 박스의 아래쪽 패딩을 지정합니다.
  final double? bottomPadding;

  /// 사다리꼴의 오른쪽이 짧은지 여부를 지정합니다. true면 오른쪽이 짧고, false면 왼쪽이 짧습니다.
  final bool isRightShort;

  /// 사다리꼴 박스의 모서리 둥글기를 지정합니다. 기본값은 0입니다.
  final double borderRadius;

  /// 사다리꼴 박스 내부에 들어갈 위젯입니다.
  final Widget? child;

  const TrapezoidBox({
    super.key,
    required this.color,
    required this.borderColor,
    required this.borderWidth,
    required this.width,
    required this.height,
    this.topPadding,
    this.bottomPadding,
    this.isRightShort = true,
    this.borderRadius = 0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: TrapezoidPainter(
          color: color,
          borderColor: borderColor,
          borderWidth: borderWidth,
          width: width,
          height: height,
          topPadding: topPadding,
          bottomPadding: bottomPadding,
          isRightShort: isRightShort,
          borderRadius: borderRadius,
        ),
        child: child, // 내부에 다른 위젯을 배치할 수 있음
      ),
    );
  }
}
