import 'package:flutter/material.dart';

/// 0~1 사이의 opacity 값을 받아 alpha가 적용된 Color를 반환합니다.
Color withOpacityValue(Color color, double opacity) {
  if (opacity < 0 || opacity > 1) {
    throw ArgumentError('opacity must be between 0 and 1');
  }
  return color.withAlpha((opacity * 255).toInt());
}
