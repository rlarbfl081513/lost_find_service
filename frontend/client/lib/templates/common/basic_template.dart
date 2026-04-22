import 'package:client/organisms/headers/header_organism.dart';
import 'package:client/templates/common/default_template.dart';
import 'package:flutter/material.dart';

class BasicTemplate extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Widget body;
  const BasicTemplate({
    super.key,
    required this.title,
    this.onBackPressed,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      header: HeaderOrganism(title: title, onBackPressed: onBackPressed),
      body: body,
    );
  }
}
