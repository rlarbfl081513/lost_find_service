// import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/services/autocomplete_service.dart';
import 'package:client/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await AutocompleteService.instance.initialize();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 라우팅 예제',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.white),
        useMaterial3: true,
      ),
      // 한국어 로케일 설정
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'), // 한국어
        Locale('en', 'US'), // 영어
      ],
      locale: const Locale('ko', 'KR'), // 기본 언어를 한국어로 설정
      // onGenerateRoute 사용 (더 유연한 라우팅)
      onGenerateRoute: (settings) {
        print('라우트 요청: ${settings.name}');
        print('등록된 라우트들: ${AppRoutes.routes.map((r) => r.path).toList()}');

        final route = AppRoutes.routes.firstWhere(
          (r) => r.path == settings.name,
          orElse: () {
            print('라우트를 찾을 수 없음: ${settings.name}');
            return AppRoute(
              // 404 페이지 라우트 -> 추후 404 페이지 제작
              path: '/404',
              builder: (context) => Scaffold(
                appBar: AppBar(title: const Text('404 - 페이지를 찾을 수 없습니다')),
                body: const Center(child: Text('요청하신 페이지를 찾을 수 없습니다.')),
              ),
            );
          },
        );

        if (route.requireAuth) {
          // 추후 로그인 인증 기능 구현 필요
        }

        return MaterialPageRoute(
          builder: route.builder, // 라우트 페이지 빌더
          settings: settings, // 라우트 설정
        );
      },
    );
  }
}
