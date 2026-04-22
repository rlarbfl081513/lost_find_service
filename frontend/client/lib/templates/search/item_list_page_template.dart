import 'package:client/templates/common/default_template.dart';
import 'package:flutter/material.dart';

class ItemListPageTemplate extends StatelessWidget {
  final Widget searchHeader;
  final Widget itemList;
  final Widget? bottomSection;
  final EdgeInsetsGeometry? padding;

  const ItemListPageTemplate({
    super.key,
    required this.searchHeader,
    required this.itemList,
    this.bottomSection,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      header: searchHeader,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
                child: itemList,
              ),
              if (bottomSection != null) ...[bottomSection!],
            ],
          ),
        ),
      ),
    );
  }
}
