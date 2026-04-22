import 'package:client/atoms/buttons/main_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String location;
  final String updatedAt;
  final String status;
  final String imageUrl;
  final VoidCallback? onDetailPressed;
  final EdgeInsetsGeometry? padding;

  const ItemCard({
    super.key,
    required this.name,
    required this.location,
    required this.updatedAt,
    required this.status,
    required this.imageUrl,
    this.onDetailPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppTextStyle.bold_16()),
                      SizedBox(height: 8),
                      Text(
                        location,
                        style: AppTextStyle.regular_10(color: AppColors.black),
                      ),
                      Text(
                        updatedAt,
                        style: AppTextStyle.regular_12(color: AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MainButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        backgroundColor: AppColors.primary_2,
                        onPressed: onDetailPressed,
                        child: Text(
                          "자세히 보기",
                          style: AppTextStyle.regular_12(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        status,
                        style: AppTextStyle.regular_12(color: AppColors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Image.asset(imageUrl, width: 120),
        ],
      ),
    );
  }
}
