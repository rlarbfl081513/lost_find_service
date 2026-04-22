import 'package:client/molecules/cards/item_card.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final List<Map<String, String>> items;
  final Function(String)? onItemTap;
  final EdgeInsetsGeometry? padding;

  const ItemList({
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
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemCard(
          name: item['name'] ?? '',
          location: item['location'] ?? '',
          updatedAt: item['updatedAt'] ?? '',
          status: item['status'] ?? '',
          imageUrl: item['imageUrl'] ?? '',
          onDetailPressed: onItemTap != null
              ? () => onItemTap!(item['id'] ?? '')
              : null,
          padding: padding,
        );
      },
    );
  }
}
