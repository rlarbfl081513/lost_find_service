import 'package:client/molecules/autocomplete_item.dart';
import 'package:flutter/material.dart';

class AutocompleteList extends StatelessWidget {
  final List<String> items;
  final Function(String)? onItemTap;
  final EdgeInsetsGeometry? padding;

  const AutocompleteList({
    super.key,
    required this.items,
    this.onItemTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: 0),
      itemBuilder: (context, index) {
        return AutocompleteItem(
          text: items[index],
          onTap: onItemTap != null ? () => onItemTap!(items[index]) : null,
          padding: padding,
        );
      },
    );
  }
}
