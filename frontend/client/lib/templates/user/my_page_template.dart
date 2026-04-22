import 'package:client/atoms/boxes/divider_line.dart';
import 'package:client/atoms/texts/content_text.dart';
import 'package:client/atoms/texts/sub_title_text.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/molecules/cards/registered_item_card.dart';
import 'package:client/templates/common/basic_template.dart';
import 'package:client/organisms/contents/notification_content.dart';
import 'package:flutter/material.dart';

class MyPageTemplate extends StatefulWidget {
  final VoidCallback onIdentityVerificationTap;
  final VoidCallback onPasswordResetTap;
  final VoidCallback onDeleteAccountTap;
  final VoidCallback onBackPressed;

  const MyPageTemplate({
    super.key,
    required this.onIdentityVerificationTap,
    required this.onPasswordResetTap,
    required this.onDeleteAccountTap,
    required this.onBackPressed,
  });

  @override
  State<MyPageTemplate> createState() => _MyPageTemplateState();
}

class _MyPageTemplateState extends State<MyPageTemplate> {
  int selectedIndex = 0;
  final List<String> tabs = ["개인정보 관리", "내가 등록한 물건", "알림"];

  @override
  Widget build(BuildContext context) {
    return BasicTemplate(
      onBackPressed: widget.onBackPressed,
      title: "마이",
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // 전환 탭
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...tabs.asMap().entries.map(
                  (entry) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = entry.key;
                      });
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedIndex == entry.key
                                ? AppColors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: SubTitleText(
                          text: tabs[entry.key],
                          textStyle: AppTextStyle.subTitle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (selectedIndex == 0)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ContentText(
                          text: "이름",
                          textStyle: AppTextStyle.bodyMedium(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        ContentText(text: "아맞다"),
                      ],
                    ),
                    DividerLine(padding: EdgeInsets.symmetric(vertical: 12)),
                    GestureDetector(
                      onTap: widget.onIdentityVerificationTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContentText(
                            text: "본인 인증",
                            textStyle: AppTextStyle.bodyMedium(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ),
                    DividerLine(padding: EdgeInsets.symmetric(vertical: 12)),
                    GestureDetector(
                      onTap: widget.onPasswordResetTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContentText(
                            text: "비밀번호 재설정",
                            textStyle: AppTextStyle.bodyMedium(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ),
                    DividerLine(padding: EdgeInsets.symmetric(vertical: 12)),
                    GestureDetector(
                      onTap: widget.onDeleteAccountTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContentText(
                            text: "회원 탈퇴",
                            textStyle: AppTextStyle.bodyMedium(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else if (selectedIndex == 1)
              // 내가 등록한 물건
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: 10,
                  itemBuilder: (context, index) => RegisteredItemCard(
                    categoryListString: "무선이어폰 > 삼성",
                    date: "2025.07.31",
                    onTap: () {},
                  ),
                ),
              ) // TODO: 내가 등록한 물건 목록 변수화
            else if (selectedIndex == 2)
              Expanded(
                child: SingleChildScrollView(
                  child: NotificationContent(), // TODO: 알림 목록 변수화
                ),
              ),
          ],
        ),
      ),
    );
  }
}
