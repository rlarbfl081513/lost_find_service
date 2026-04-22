import 'package:client/atoms/buttons/primary_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:client/core/constants/api_endpoints.dart';
import 'package:client/core/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiTestPage extends StatefulWidget {
  const ApiTestPage({super.key});

  @override
  State<ApiTestPage> createState() => _ApiTestPageState();
}

class _ApiTestPageState extends State<ApiTestPage> {
  final ApiService _apiService = ApiService();
  String _testResult = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('API 연결 테스트', style: AppTextStyle.bold_20()),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Text('API 연결 테스트', style: AppTextStyle.bold_24()),
            const SizedBox(height: 8),
            Text(
              '각 버튼을 눌러 API 연결을 테스트할 수 있습니다.',
              style: AppTextStyle.regular_14(color: AppColors.gray_1),
            ),
            const SizedBox(height: 32),

            // API 기본 정보
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.gray_3,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('API 정보', style: AppTextStyle.bold_14()),
                  const SizedBox(height: 8),
                  Text(
                    'Base URL: ${ApiEndpoints.baseUrl}\n'
                    'API Path: ${ApiEndpoints.path}',
                    style: AppTextStyle.regular_12(color: AppColors.gray_1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 테스트 버튼들
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 연결 테스트
                    PrimaryButton(
                      text: _isLoading ? '테스트 중...' : '🔗 기본 연결 테스트',
                      onPressed: _isLoading ? null : _testBasicConnection,
                    ),
                    const SizedBox(height: 12),

                    // 아이템 목록 테스트
                    PrimaryButton(
                      text: _isLoading ? '테스트 중...' : '📋 아이템 목록 조회',
                      onPressed: _isLoading ? null : _testItemList,
                    ),
                    const SizedBox(height: 12),

                    // 검색 테스트
                    PrimaryButton(
                      text: _isLoading ? '테스트 중...' : '🔍 검색 API 테스트',
                      onPressed: _isLoading ? null : _testSearch,
                    ),
                    const SizedBox(height: 12),

                    // 로봇 위치 테스트
                    PrimaryButton(
                      text: _isLoading ? '테스트 중...' : '🤖 로봇 위치 조회',
                      onPressed: _isLoading ? null : _testRobotLocation,
                    ),
                    const SizedBox(height: 12),

                    // POST 요청 테스트
                    PrimaryButton(
                      text: _isLoading ? '테스트 중...' : '📤 POST 요청 테스트',
                      onPressed: _isLoading ? null : _testPostRequest,
                    ),
                    const SizedBox(height: 24),

                    // 결과 표시 영역
                    if (_testResult.isNotEmpty) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.gray_3,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.black, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('테스트 결과', style: AppTextStyle.bold_14()),
                            const SizedBox(height: 8),
                            Text(
                              _testResult,
                              style: AppTextStyle.regular_12(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(text: '결과 초기화', onPressed: _clearResult),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 기본 연결 테스트
  Future<void> _testBasicConnection() async {
    setState(() {
      _isLoading = true;
      _testResult = '연결 테스트 중...';
    });

    try {
      final response = await Dio().get(ApiEndpoints.baseUrl);
      setState(() {
        _testResult =
            '✅ 기본 연결 성공!\n'
            'Status: ${response.statusCode}\n'
            'Data: ${response.data}';
      });
    } catch (e) {
      setState(() {
        _testResult =
            '❌ 기본 연결 실패\n'
            'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 아이템 목록 조회 테스트
  Future<void> _testItemList() async {
    setState(() {
      _isLoading = true;
      _testResult = '아이템 목록 조회 중...';
    });

    try {
      final response = await _apiService.get(ApiEndpoints.itemList);
      setState(() {
        _testResult =
            '✅ 아이템 목록 조회 성공!\n'
            'Status: ${response.statusCode}\n'
            'Data: ${response.data}';
      });
    } catch (e) {
      setState(() {
        _testResult =
            '❌ 아이템 목록 조회 실패\n'
            'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 검색 API 테스트
  Future<void> _testSearch() async {
    setState(() {
      _isLoading = true;
      _testResult = '검색 API 테스트 중...';
    });

    try {
      final response = await _apiService.get(
        ApiEndpoints.search,
        queryParameters: {'q': 'test'},
      );
      setState(() {
        _testResult =
            '✅ 검색 API 테스트 성공!\n'
            'Status: ${response.statusCode}\n'
            'Data: ${response.data}';
      });
    } catch (e) {
      setState(() {
        _testResult =
            '❌ 검색 API 테스트 실패\n'
            'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 로봇 위치 조회 테스트
  Future<void> _testRobotLocation() async {
    setState(() {
      _isLoading = true;
      _testResult = '로봇 위치 조회 중...';
    });

    try {
      final response = await _apiService.get(ApiEndpoints.robotLocation);
      setState(() {
        _testResult =
            '✅ 로봇 위치 조회 성공!\n'
            'Status: ${response.statusCode}\n'
            'Data: ${response.data}';
      });
    } catch (e) {
      setState(() {
        _testResult =
            '❌ 로봇 위치 조회 실패\n'
            'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// POST 요청 테스트
  Future<void> _testPostRequest() async {
    setState(() {
      _isLoading = true;
      _testResult = 'POST 요청 테스트 중...';
    });

    try {
      final response = await _apiService.post(
        ApiEndpoints.userLogin,
        data: {'email': 'test@example.com', 'password': 'testpassword'},
      );
      setState(() {
        _testResult =
            '✅ POST 요청 테스트 성공!\n'
            'Status: ${response.statusCode}\n'
            'Data: ${response.data}';
      });
    } catch (e) {
      setState(() {
        _testResult =
            '❌ POST 요청 테스트 실패\n'
            'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 결과 초기화
  void _clearResult() {
    setState(() {
      _testResult = '';
    });
  }
}
