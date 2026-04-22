import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:client/core/utils/color_utils.dart';

class MainButton extends StatelessWidget {
  /// 버튼 내부에 들어갈 위젯입니다.
  final Widget child;

  /// 버튼의 테두리를 지정합니다.
  final Border? border;

  /// 버튼의 모서리 둥글기를 지정합니다. 기본값은 20입니다.
  final double? borderRadius;

  /// 버튼의 배경색을 지정합니다.
  final Color? backgroundColor;

  /// 버튼을 클릭했을 때 실행할 콜백 함수입니다.
  final VoidCallback? onPressed;

  /// 버튼의 가로 길이를 지정합니다.
  final double? width;

  /// 버튼의 세로 길이를 지정합니다.
  final double? height;

  /// 터치 시 물결 효과 색상을 지정합니다.
  final Color? splashColor;

  /// 터치 시 하이라이트 색상을 지정합니다.
  final Color? highlightColor;

  /// 버튼이 비활성화 상태인지 여부를 지정합니다.
  final bool isEnabled;

  /// 버튼 내부의 패딩을 지정합니다.
  final EdgeInsetsGeometry? padding;

  const MainButton({
    super.key,
    required this.child,
    this.border,
    this.borderRadius = 20,
    this.backgroundColor,
    this.onPressed,
    this.width,
    this.height,
    this.splashColor,
    this.highlightColor,
    this.isEnabled = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        splashColor: splashColor ?? withOpacityValue(Colors.white, 0.3),
        highlightColor: highlightColor ?? withOpacityValue(Colors.black, 0.1),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: isEnabled
                ? (backgroundColor ?? AppColors.primary_1)
                : withOpacityValue(backgroundColor ?? AppColors.primary_1, .5),
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            border: border,
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Center(
              child: Opacity(opacity: isEnabled ? 1.0 : 0.5, child: child),
            ),
          ),
        ),
      ),
    );
  }
}
