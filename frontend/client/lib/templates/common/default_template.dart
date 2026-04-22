import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultTemplate extends StatelessWidget {
  final Widget header;
  final Widget body;
  const DefaultTemplate({super.key, required this.header, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray_2,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SafeArea(bottom: false, child: header),
      ),
      body: body,
    );
  }
}
