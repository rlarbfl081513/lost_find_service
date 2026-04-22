import 'package:client/molecules/forms/search_bar.dart';
import 'package:client/molecules/headers/page_header.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFilterPressed;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool isEnabled;
  final EdgeInsetsGeometry? padding;

  const SearchHeader({
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
    return PageHeader(
      onBackPressed: onBackPressed,
      frontSpacing: 12,
      trailing: SizedBox(width: 0),
      padding:
          padding ?? EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 16),
      title: SearchBarMolecule(
        controller: controller,
        hintText: hintText,
        onFilterPressed: onFilterPressed,
        onSubmitted: onSubmitted,
        onTap: onTap,
        isEnabled: isEnabled,
        padding: EdgeInsets.zero,
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding:
  //         padding ?? EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 16),
  //     child: SearchBarMolecule(
  //       controller: controller,
  //       hintText: hintText,
  //       onBackPressed: onBackPressed,
  //       onFilterPressed: onFilterPressed,
  //       onSubmitted: onSubmitted,
  //       onTap: onTap,
  //       isEnabled: isEnabled,
  //       padding: EdgeInsets.zero,
  //     ),
  //   );
  // }
}
