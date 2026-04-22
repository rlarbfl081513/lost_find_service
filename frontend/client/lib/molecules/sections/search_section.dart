import 'package:client/atoms/texts/section_title.dart';
import 'package:client/molecules/lists/tag_list.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  final String title;
  final List<String> tags;
  final bool isDeleteable;
  final Function(String)? onDelete;
  final EdgeInsetsGeometry? padding;
  final bool isSelectable;

  const SearchSection({
    super.key,
    required this.title,
    required this.tags,
    this.isDeleteable = false,
    this.onDelete,
    this.padding,
    this.isSelectable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: title,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
        ),
        SizedBox(height: 6),
        TagList(
          tags: tags,
          isDeleteable: isDeleteable,
          onDelete: onDelete,
          isSelectable: isSelectable,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
