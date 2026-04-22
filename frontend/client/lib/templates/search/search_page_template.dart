import 'package:client/templates/common/default_template.dart';
import 'package:flutter/material.dart';

class SearchPageTemplate extends StatelessWidget {
  final Widget searchHeader;
  final List<Widget> searchSections;
  final Widget? autocompleteList;
  final Widget? speechBubble;
  final Widget? reportButton;
  final EdgeInsetsGeometry? padding;

  const SearchPageTemplate({
    super.key,
    required this.searchHeader,
    required this.searchSections,
    this.autocompleteList,
    this.speechBubble,
    this.reportButton,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      header: searchHeader,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (searchSections.isNotEmpty) ...[...searchSections],
            if (speechBubble != null) ...[
              Center(child: speechBubble!),
              SizedBox(height: 48),
            ],
            if (reportButton != null) ...[
              Padding(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
                child: reportButton!,
              ),
            ],
            if (autocompleteList != null) ...[autocompleteList!],
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Color(0xffF2F4F5),
  //     body: SafeArea(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           searchHeader,
  //           if (searchSections.isNotEmpty) ...[...searchSections],
  //           if (speechBubble != null) ...[
  //             Center(child: speechBubble!),
  //             SizedBox(height: 48),
  //           ],
  //           if (reportButton != null) ...[
  //             Padding(
  //               padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
  //               child: reportButton!,
  //             ),
  //           ],
  //           if (autocompleteList != null) ...[autocompleteList!],
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
