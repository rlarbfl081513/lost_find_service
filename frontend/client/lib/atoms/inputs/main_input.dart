import 'package:flutter/material.dart';

class MainInput extends StatelessWidget {
  /// 인풋 박스의 가로 길이. null이면 화면에 꽉 차게 표시됩니다.
  final double? width;

  /// 인풋 박스의 세로 길이. null이면 기본 높이로 표시됩니다.
  final double? height;

  /// 텍스트 입력창 왼쪽에 표시할 아이콘 위젯. null이면 아이콘이 없습니다.
  final Widget? leadingIcon;

  /// 텍스트 입력창 오른쪽에 표시할 아이콘 위젯. null이면 아이콘이 없습니다.
  final Widget? trailingIcon;

  /// 텍스트 입력을 제어할 컨트롤러. 부모에서 입력값을 직접 관리할 때 사용합니다.
  final TextEditingController? controller;

  /// 텍스트가 변경될 때마다 호출되는 콜백 함수입니다.
  final ValueChanged<String>? onChanged;

  /// 입력창에 표시할 힌트 텍스트입니다.
  final String? hintText;

  /// 비밀번호 입력 등 텍스트를 가려야 할 때 true로 설정합니다.
  final bool obscureText;

  /// 키보드 타입을 지정합니다. (예: 숫자, 이메일 등)
  final TextInputType? keyboardType;

  /// 입력창 내부의 패딩을 지정합니다.
  final EdgeInsetsGeometry? contentPadding;

  /// 입력창의 테두리(border)를 지정합니다.
  final InputBorder? border;

  /// 입력창의 배경색을 지정합니다.
  final Color? fillColor;

  /// 입력 텍스트의 스타일(색상 등)을 지정합니다.
  final TextStyle? textStyle;

  /// 힌트(placeholder) 텍스트의 스타일(색상 등)을 지정합니다.
  final TextStyle? hintStyle;

  /// 입력창이 활성화(enabled) 상태일 때의 테두리(border)를 지정합니다.
  final InputBorder? enabledBorder;

  /// 입력창이 포커스(focused) 상태일 때의 테두리(border)를 지정합니다.
  final InputBorder? focusedBorder;

  /// 입력창이 에러 상태일 때의 테두리(border)를 지정합니다.
  final InputBorder? errorBorder;

  /// 입력창이 비활성화(disabled) 상태일 때의 테두리(border)를 지정합니다.
  final InputBorder? disabledBorder;

  /// 입력창의 그림자 효과를 지정합니다.
  final List<BoxShadow>? boxShadow;

  /// 입력창이 클릭될 때 호출되는 콜백 함수입니다.
  final VoidCallback? onTap;

  /// 입력 완료 시 호출되는 콜백 함수입니다.
  final ValueChanged<String>? onSubmitted;

  final bool isEnabled;

  const MainInput({
    super.key,
    this.width,
    this.height,
    this.leadingIcon,
    this.trailingIcon,
    this.controller,
    this.onChanged,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 12,
    ),
    this.border = const OutlineInputBorder(),
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.fillColor,
    this.textStyle,
    this.hintStyle,
    this.boxShadow = const [],
    this.onTap,
    this.onSubmitted,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget textField = TextField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: textStyle,
      enabled: isEnabled,
      decoration: InputDecoration(
        border: border,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        disabledBorder: disabledBorder,
        hintText: hintText,
        hintStyle: hintStyle,
        isDense: true,
        contentPadding: contentPadding,
        prefixIcon: leadingIcon,
        suffixIcon: trailingIcon,
        fillColor: fillColor,
        filled: fillColor != null,
      ),
    );

    Widget container = Container(
      decoration: BoxDecoration(boxShadow: boxShadow),
      width: width ?? double.infinity,
      height: height,
      child: textField,
    );

    // onTap이 제공된 경우 GestureDetector로 감싸기
    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: container);
    }

    return container;
  }
}
