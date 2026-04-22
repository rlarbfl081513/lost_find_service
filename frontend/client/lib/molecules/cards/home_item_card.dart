import 'dart:ui';

import 'package:client/atoms/buttons/main_button.dart';
import 'package:client/atoms/cards/image_card.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class HomeItemCard extends StatelessWidget {
  final ImageProvider imageProvider;
  final String date;
  final String category;
  final VoidCallback? onTap;
  const HomeItemCard({
    super.key,
    required this.imageProvider,
    required this.date,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ImageCard(
      imageProvider: imageProvider,
      width: 300,
      height: 230,
      boxShadow: [
        BoxShadow(
          color: withOpacityValue(AppColors.black, .06),
          blurRadius: 10,
          offset: Offset(0, 4),
          blurStyle: BlurStyle.normal,
        ),
      ],
      borderRadius: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            // padding: EdgeInsets.zero,
            // height: 93,
            decoration: BoxDecoration(
              color: withOpacityValue(AppColors.white, .6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(category, style: AppTextStyle.bold_20()),
                          SizedBox(height: 4),
                          Text("서울시 강남구", style: AppTextStyle.regular_12()),
                          Text(date, style: AppTextStyle.regular_12()),
                        ],
                      ),
                      MainButton(
                        border: Border.all(
                          color: withOpacityValue(AppColors.black, .3),
                          width: 1,
                        ),
                        borderRadius: 20,
                        backgroundColor: AppColors.white.withAlpha(150),
                        width: 40,
                        height: 40,
                        onPressed: onTap,
                        child: Center(
                          child: Icon(
                            Icons.keyboard_double_arrow_right_rounded,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
