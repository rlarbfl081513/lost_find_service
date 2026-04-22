import 'package:client/atoms/inputs/main_input.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:client/molecules/headers/logo_header.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String logoImagePath;
  final String logoText;
  final String heroText;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSearchTap;
  final EdgeInsetsGeometry? padding;

  const HomeHeader({
    super.key,
    required this.logoImagePath,
    required this.logoText,
    required this.heroText,
    this.onMenuPressed,
    this.onSearchTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      color: AppColors.primary_1,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: Column(
            children: [
              LogoHeader(
                logoImagePath: logoImagePath,
                logoText: logoText,
                onMenuPressed: onMenuPressed,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heroText,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.translate(
                offset: Offset(0, 24),
                child: MainInput(
                  isEnabled: false,
                  onTap: onSearchTap,
                  boxShadow: [
                    BoxShadow(
                      color: withOpacityValue(AppColors.black, 0.08),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  hintText: '무엇을 잃어버리셨나요?',
                  fillColor: AppColors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                  leadingIcon: Icon(Icons.search, size: 18),
                  textStyle: AppTextStyle.regular_14(),
                  hintStyle: AppTextStyle.regular_14(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
