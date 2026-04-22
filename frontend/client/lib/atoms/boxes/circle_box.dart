import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CircleBox extends StatelessWidget {
  /// 원형 박스 내부에 들어갈 위젯입니다.
  final Widget child;

  /// 원형 박스의 크기(지름)를 지정합니다. 기본값은 40입니다.
  final double? size;

  /// 원형 박스의 배경색을 지정합니다. null이면 기본 색상이 적용됩니다.
  final Color? backgroundColor;

  /// 원형 박스의 테두리를 지정합니다. null이면 테두리가 없습니다.
  final Border? border;

  /// 원형 박스의 클리핑 동작을 지정합니다. null이면 클리핑이 없습니다.
  final Clip? clipBehavior;

  const CircleBox({
    super.key,
    required this.child,
    this.size = 40,
    this.border,
    this.backgroundColor,
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary_1,
        borderRadius: BorderRadius.circular(size! / 2),
        border: border ?? Border.all(style: BorderStyle.none),
      ),
      clipBehavior: clipBehavior ?? Clip.none,
      child: Center(child: child),
    );
  }
}
