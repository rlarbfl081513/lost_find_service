import 'package:client/atoms/buttons/main_button.dart';
import 'package:client/atoms/boxes/border_box.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < 4; i++)
            MainButton(
              onPressed: () {},
              backgroundColor: Colors.white.withAlpha(0),
              border: Border.all(style: BorderStyle.none),
              width: 65,
              child: Column(
                spacing: 6,
                children: [
                  BorderBox(
                    width: 65,
                    height: 62,
                    border: Border.all(color: AppColors.black, width: 1),
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Iconify(
                        Ion.wallet,
                        size: 35,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Text("시계", style: AppTextStyle.regular_12()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
