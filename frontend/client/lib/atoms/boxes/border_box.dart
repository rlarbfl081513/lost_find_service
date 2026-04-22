// import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BorderBox extends StatelessWidget {
  /// 박스 내부에 들어갈 위젯입니다.
  final Widget? child;

  /// 박스의 모서리 둥글기를 지정합니다. null이면 기본값 10이 적용됩니다.
  final double? borderRadius;

  /// 박스의 배경색을 지정합니다.
  final Color? backgroundColor;

  /// 박스의 테두리를 지정합니다.
  final Border? border;

  /// 박스 내부의 패딩을 지정합니다. null이면 패딩이 없습니다.
  final EdgeInsets? padding;

  /// 박스의 가로 길이를 지정합니다. null이면 화면에 꽉 차게 표시됩니다.
  final double? width;

  /// 박스의 세로 길이를 지정합니다.
  final double? height;

  /// 박스 내부의 정렬 방식을 지정합니다.
  final Alignment? alignment;

  /// 박스의 그라데이션을 지정합니다.
  final Gradient? gradient;

  const BorderBox({
    super.key,
    this.child,
    this.borderRadius = 10,
    this.backgroundColor,
    this.border,
    this.padding = EdgeInsets.zero,
    this.width,
    this.height,
    this.alignment,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: width ?? double.infinity,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius!),
        border: border,
      ),
      child: child,
    );
  }
}
