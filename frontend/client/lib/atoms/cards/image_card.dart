// import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  /// 카드 내부에 들어갈 위젯입니다.
  final Widget? child;

  /// 카드의 배경 이미지를 지정합니다.
  final ImageProvider? imageProvider;

  /// 카드의 가로 길이를 지정합니다. null이면 화면에 꽉 차게 표시됩니다.
  final double? width;

  /// 카드의 세로 길이를 지정합니다.
  final double? height;

  /// 카드의 모서리 둥글기를 지정합니다. 기본값은 0입니다.
  final double? borderRadius;

  /// 카드의 배경색을 지정합니다.
  final Color? backgroundColor;

  /// 카드의 테두리를 지정합니다.
  final Border? border;

  /// 카드를 탭했을 때 실행할 콜백 함수입니다.
  final VoidCallback? onTap;

  /// 카드의 그림자 효과를 지정합니다.
  final List<BoxShadow>? boxShadow;

  const ImageCard({
    super.key,
    this.child,
    this.imageProvider,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.backgroundColor,
    this.border,
    this.onTap,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius!),
          border: border,
          image: imageProvider != null
              ? DecorationImage(
                  image: imageProvider!,
                  fit: BoxFit.cover, // 이미지 비율 유지
                )
              : null,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
