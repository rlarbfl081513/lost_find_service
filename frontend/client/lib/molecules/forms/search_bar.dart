import 'package:client/atoms/inputs/main_input.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class SearchBarMolecule extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFilterPressed;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool isEnabled;
  final EdgeInsetsGeometry? padding;

  const SearchBarMolecule({
    super.key,
    this.controller,
    this.hintText,
    this.onBackPressed,
    this.onFilterPressed,
    this.onSubmitted,
    this.onTap,
    this.isEnabled = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return MainInput(
      controller: controller,
      isEnabled: isEnabled,
      onTap: onTap,
      hintText: hintText ?? "무엇을 잃어버리셨나요?",
      hintStyle: AppTextStyle.regular_14(color: Colors.grey),
      fillColor: AppColors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      onSubmitted: onSubmitted,
      leadingIcon: Icon(Icons.search, size: 24),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     children: [
  //       MainInput(
  //         controller: controller,
  //         isEnabled: isEnabled,
  //         onTap: onTap,
  //         hintText: hintText ?? "무엇을 잃어버리셨나요?",
  //         hintStyle: AppTextStyle.regular_14(color: Colors.grey),
  //         fillColor: AppColors.white,
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide.none,
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide.none,
  //         ),
  //         disabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           borderSide: BorderSide.none,
  //         ),
  //         onSubmitted: onSubmitted,
  //         leadingIcon: Icon(Icons.search, size: 24),
  //       ),
  //       if (onFilterPressed != null) ...[
  //         SizedBox(width: 6),
  //         IconButtonAtom(
  //           icon: Icons.filter_list,
  //           onPressed: onFilterPressed,
  //           backgroundColor: AppColors.white,
  //         ),
  //       ],
  //     ],
  //   );
  // }
}
