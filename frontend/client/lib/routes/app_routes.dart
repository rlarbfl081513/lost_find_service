import 'package:client/pages/auth/identity_verification_page.dart';
import 'package:client/pages/auth/login_page.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/search/item_list_page.dart';
import 'package:client/pages/search/item_detail_page.dart';
import 'package:client/pages/pickup/pickup_tracking_page.dart';
import 'package:client/pages/search/search_category_page.dart';
import 'package:client/pages/test/autocomplete_test_page.dart';
import 'package:client/pages/test/router_test_page.dart';
import 'package:client/pages/test/api_test_page.dart';
import 'package:client/pages/search/search_page.dart';
import 'package:client/pages/pickup/pickup_select_page.dart';
import 'package:client/pages/user/item_report_page.dart';
import 'package:client/pages/user/my_page.dart';
// import 'package:client/templates/home_templates.dart';
import 'package:flutter/material.dart';

class AppRoute {
  final String path; // 라우트 경로
  final WidgetBuilder builder; // 라우트 페이지 빌더
  final bool requireAuth; // 로그인 인증 필요 여부

  const AppRoute({
    // 생성자
    required this.path,
    required this.builder,
    this.requireAuth = false,
  });
}

class AppRoutes {
  static final List<AppRoute> routes = [
    AppRoute(
      path: '/',
      builder: (context) => const RouterTestPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/search',
      builder: (context) => const SearchPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/item-list',
      builder: (context) => const ItemListPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/item-detail',
      builder: (context) => const ItemDetailPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/search-category',
      builder: (context) => const SearchCategoryPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/autocomplete-test',
      builder: (context) => const AutocompleteTestPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/pickup',
      builder: (context) => const PickupSelectPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/router-test',
      builder: (context) => const RouterTestPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/pickup-tracking',
      builder: (context) => const PickupTrackingPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/login',
      builder: (context) => LoginPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/identity-verification',
      builder: (context) => const IdentityVerificationPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/api-test',
      builder: (context) => const ApiTestPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/my-page',
      builder: (context) => const MyPage(),
      requireAuth: false,
    ),
    AppRoute(
      path: '/item-report',
      builder: (context) => const ItemReportPage(),
      requireAuth: false,
    ),
  ];
}
