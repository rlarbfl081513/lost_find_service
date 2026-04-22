import 'package:client/core/services/autocomplete_service.dart';
import 'package:flutter/material.dart';
import 'package:client/atoms/texts/autocomplete_text_field.dart';

/// 자동완성 기능 테스트 페이지
class AutocompleteTestPage extends StatefulWidget {
  const AutocompleteTestPage({super.key});

  @override
  State<AutocompleteTestPage> createState() => _AutocompleteTestPageState();
}

class _AutocompleteTestPageState extends State<AutocompleteTestPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  String _selectedSuggestion1 = '';
  String _selectedSuggestion2 = '';
  String _selectedSuggestion3 = '';

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('자동완성 테스트'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 서비스 상태 정보
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '자동완성 서비스 상태',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '초기화 상태: ${AutocompleteService.instance.isInitialized ? "완료" : "미완료"}',
                      ),
                      Text(
                        '등록된 단어 수: ${AutocompleteService.instance.wordCount}개',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // 오버레이 자동완성 텍스트 필드
              Text(
                '1. 오버레이 자동완성 (AutocompleteTextField)',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              AutocompleteTextField(
                controller: _controller1,
                hintText: '단어를 입력하세요...',
                labelText: '오버레이 자동완성',
                maxSuggestions: 8,
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    _selectedSuggestion1 = suggestion;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
              if (_selectedSuggestion1.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '선택된 단어: $_selectedSuggestion1',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 24.0),

              // 간단한 자동완성 텍스트 필드
              Text(
                '2. 드롭다운 자동완성 (SimpleAutocompleteTextField)',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              SimpleAutocompleteTextField(
                controller: _controller2,
                hintText: '단어를 입력하세요...',
                labelText: '드롭다운 자동완성',
                maxSuggestions: 5,
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    _selectedSuggestion2 = suggestion;
                  });
                },
              ),
              if (_selectedSuggestion2.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '선택된 단어: $_selectedSuggestion2',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 24.0),

              // 일반 텍스트 필드 (비교용)
              Text(
                '3. 일반 텍스트 필드 (비교용)',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _controller3,
                decoration: InputDecoration(
                  hintText: '일반 텍스트 필드...',
                  labelText: '일반 텍스트 필드',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedSuggestion3 = value;
                  });
                },
              ),
              if (_selectedSuggestion3.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '입력된 텍스트: $_selectedSuggestion3',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 32.0),

              // 테스트 버튼들
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '테스트 기능',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _testSearch('안녕'),
                              child: const Text('한국어 테스트'),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _testSearch('hello'),
                              child: const Text('영어 테스트'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _testSearch('app'),
                              child: const Text('접두사 테스트'),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _testSearch('ing'),
                              child: const Text('접미사 테스트'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _testSearch('ㄱ'),
                              child: const Text('초성 테스트'),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _clearAll,
                              child: const Text('모두 지우기'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _testSearch(String query) {
    final results = AutocompleteService.instance.search(query);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('"$query" 검색 결과'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(results[index]),
                onTap: () {
                  Navigator.of(context).pop();
                  _controller1.text = results[index];
                  setState(() {
                    _selectedSuggestion1 = results[index];
                  });
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _clearAll() {
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    setState(() {
      _selectedSuggestion1 = '';
      _selectedSuggestion2 = '';
      _selectedSuggestion3 = '';
    });
  }
}
