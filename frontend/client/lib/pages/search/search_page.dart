import 'package:client/atoms/boxes/speech_bubble.dart';
import 'package:client/atoms/buttons/main_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/core/services/autocomplete_service.dart';
import 'package:client/molecules/lists/autocomplete_list.dart';
import 'package:client/organisms/headers/search_header.dart';
import 'package:client/molecules/sections/search_section.dart';
import 'package:client/templates/search/search_page_template.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> recentSearchList = ["삼성", "애플", "S22 이하", "S23 이상", "시계"];
  List<String> recommendedSearchList = [
    "삼성",
    "애플",
    "S22 이하",
    "S23 이상",
    "Z폴드",
    "Z플립",
    "갤럭시",
  ];
  late TextEditingController _searchController;
  bool _isSearchEmpty = true;
  List<String> _autoCompleteList = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
    _initializeAutocompleteService();
  }

  Future<void> _initializeAutocompleteService() async {
    try {
      await AutocompleteService.instance.initialize();
      print('자동완성 서비스 초기화 완료');
    } catch (e) {
      print('자동완성 서비스 초기화 실패: $e');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _isSearchEmpty = _searchController.text.isEmpty;

      if (_searchController.text.isEmpty) {
        _autoCompleteList = [];
      } else {
        _autoCompleteList = AutocompleteService.instance.search(
          _searchController.text,
        );
      }
    });
  }

  void goBack() {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SearchPageTemplate(
      searchHeader: SearchHeader(
        controller: _searchController,
        onBackPressed: goBack,
        onSubmitted: (value) {
          Navigator.pushNamed(context, "/item-list");
        },
      ),
      searchSections: _isSearchEmpty
          ? [
              SearchSection(
                title: "최근 검색어",
                tags: recentSearchList,
                isDeleteable: true,
                isSelectable: true,
              ),
              SearchSection(
                title: "추천 검색어",
                tags: recommendedSearchList,
                isSelectable: true,
              ),
            ]
          : [],
      speechBubble: _isSearchEmpty
          ? SpeechBubble(
              backgroundColor: Color(0xffebebeb),
              child: Text("잃어버린 물건이 있나요???", style: AppTextStyle.bold_12()),
            )
          : null,
      reportButton: _isSearchEmpty
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -50,
                  left: 30,
                  width: 55,
                  child: Transform.scale(
                    scaleX: -1,
                    child: Image.asset("assets/images/yogi.png"),
                  ),
                ),
                MainButton(
                  borderRadius: 20,
                  backgroundColor: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.share_arrival_time, size: 24),
                        Row(
                          children: [
                            Text(
                              "내가 잃어버린 물건 신고하러가기",
                              style: AppTextStyle.regular_12(),
                            ),
                            Icon(Icons.keyboard_arrow_right_outlined, size: 24),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : null,
      autocompleteList: !_isSearchEmpty
          ? AutocompleteList(
              items: _autoCompleteList,
              onItemTap: (text) {
                _searchController.text = text;
                Navigator.pushNamed(context, "/item-list");
              },
            )
          : null,
    );
  }
}
