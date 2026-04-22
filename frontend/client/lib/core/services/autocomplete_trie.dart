/// Trie 노드 클래스
class TrieNode {
  Map<String, TrieNode> children = {};
  bool isEndOfWord = false;
  List<String> words = []; // 해당 노드에서 끝나는 모든 단어들
  int frequency = 0; // 단어 사용 빈도
}

/// 자동완성을 위한 Trie 자료구조
class AutocompleteTrie {
  TrieNode _root = TrieNode();
  bool _isInitialized = false;

  /// Trie 초기화 상태 확인
  bool get isInitialized => _isInitialized;

  /// 단어 삽입 (정방향 - 접두사 검색용)
  void insert(String word) {
    if (word.isEmpty) return;

    TrieNode current = _root;
    final lowercaseWord = word.toLowerCase();

    for (int i = 0; i < lowercaseWord.length; i++) {
      final char = lowercaseWord[i];
      current.children.putIfAbsent(char, () => TrieNode());
      current = current.children[char]!;

      // 각 노드에 원본 단어 저장 (대소문자 유지)
      if (!current.words.contains(word)) {
        current.words.add(word);
      }
    }
    current.isEndOfWord = true;
  }

  /// 접두사 검색
  List<String> searchByPrefix(String prefix) {
    if (prefix.isEmpty) return [];

    TrieNode current = _root;
    final lowercasePrefix = prefix.toLowerCase();

    // 접두사까지 이동
    for (int i = 0; i < lowercasePrefix.length; i++) {
      final char = lowercasePrefix[i];
      if (!current.children.containsKey(char)) {
        return []; // 접두사가 존재하지 않음
      }
      current = current.children[char]!;
    }

    // 해당 노드의 모든 단어 반환
    return current.words;
  }

  /// 접미사 검색을 위한 역방향 Trie
  List<String> searchBySuffix(String suffix) {
    if (suffix.isEmpty) return [];

    final results = <String>{};
    final lowercaseSuffix = suffix.toLowerCase();

    // 모든 단어에서 접미사 검색
    _searchSuffixRecursive(_root, '', lowercaseSuffix, results);

    return results.toList();
  }

  /// 접미사 검색 재귀 함수
  void _searchSuffixRecursive(
    TrieNode node,
    String currentWord,
    String suffix,
    Set<String> results,
  ) {
    if (node.isEndOfWord) {
      final lowercaseWord = currentWord.toLowerCase();
      if (lowercaseWord.endsWith(suffix)) {
        results.addAll(node.words);
      }
    }

    for (final entry in node.children.entries) {
      _searchSuffixRecursive(
        entry.value,
        currentWord + entry.key,
        suffix,
        results,
      );
    }
  }

  /// 중간 글자 검색 (포함된 부분이 일치)
  List<String> searchBySubstring(String substring) {
    if (substring.isEmpty) return [];

    final results = <String>{};
    final lowercaseSubstring = substring.toLowerCase();

    // 모든 단어에서 부분 문자열 검색
    _searchSubstringRecursive(_root, '', lowercaseSubstring, results);

    return results.toList();
  }

  /// 부분 문자열 검색 재귀 함수
  void _searchSubstringRecursive(
    TrieNode node,
    String currentWord,
    String substring,
    Set<String> results,
  ) {
    if (node.isEndOfWord) {
      final lowercaseWord = currentWord.toLowerCase();
      if (lowercaseWord.contains(substring)) {
        results.addAll(node.words);
      }
    }

    for (final entry in node.children.entries) {
      _searchSubstringRecursive(
        entry.value,
        currentWord + entry.key,
        substring,
        results,
      );
    }
  }

  /// 한국어 초성 검색
  List<String> searchByKoreanInitial(String initialQuery) {
    if (initialQuery.isEmpty) return [];

    final results = <String>{};
    _searchKoreanInitialRecursive(_root, '', initialQuery, results);

    return results.toList();
  }

  /// 한국어 초성 검색 재귀 함수
  void _searchKoreanInitialRecursive(
    TrieNode node,
    String currentWord,
    String initialQuery,
    Set<String> results,
  ) {
    if (node.isEndOfWord) {
      final wordInitials = _getKoreanInitials(currentWord);
      if (wordInitials.contains(initialQuery)) {
        results.addAll(node.words);
      }
    }

    for (final entry in node.children.entries) {
      _searchKoreanInitialRecursive(
        entry.value,
        currentWord + entry.key,
        initialQuery,
        results,
      );
    }
  }

  /// 한국어 초성 추출
  String _getKoreanInitials(String word) {
    const List<String> initialTable = [
      'ㄱ',
      'ㄲ',
      'ㄴ',
      'ㄷ',
      'ㄸ',
      'ㄹ',
      'ㅁ',
      'ㅂ',
      'ㅃ',
      'ㅅ',
      'ㅆ',
      'ㅇ',
      'ㅈ',
      'ㅉ',
      'ㅊ',
      'ㅋ',
      'ㅌ',
      'ㅍ',
      'ㅎ',
    ];
    String initials = '';
    for (int i = 0; i < word.length; i++) {
      final char = word[i];
      final code = char.codeUnitAt(0);
      if (code >= 0xAC00 && code <= 0xD7A3) {
        // 한글 음절
        final initialIndex = ((code - 0xAC00) ~/ 28) ~/ 21;
        initials += initialTable[initialIndex];
      } else {
        initials += char.toLowerCase();
      }
    }
    return initials;
  }

  /// 통합 검색 (접두사, 접미사, 중간 글자, 초성 모두 고려)
  List<String> search(String query) {
    if (query.isEmpty) return [];

    final results = <String, int>{}; // 단어별 점수

    // 1. 접두사 검색 (가장 높은 점수)
    final prefixResults = searchByPrefix(query);
    for (final word in prefixResults) {
      results[word] = (results[word] ?? 0) + 100;
    }

    // 2. 접미사 검색 (중간 점수)
    final suffixResults = searchBySuffix(query);
    for (final word in suffixResults) {
      results[word] = (results[word] ?? 0) + 50;
    }

    // 3. 중간 글자 검색 (낮은 점수)
    final substringResults = searchBySubstring(query);
    for (final word in substringResults) {
      results[word] = (results[word] ?? 0) + 10;
    }

    // 4. 한국어 초성 검색 (시작하는 단어 우선)
    final initialResults = searchByKoreanInitial(query);
    final startsWithInitial = <String>[];
    final containsInitial = <String>[];
    for (final word in initialResults) {
      final initials = _getKoreanInitials(word);
      if (initials.startsWith(query)) {
        startsWithInitial.add(word);
      } else {
        containsInitial.add(word);
      }
    }
    final sortedInitialResults = [...startsWithInitial, ...containsInitial];
    for (final word in sortedInitialResults) {
      results[word] = (results[word] ?? 0) + 30;
    }

    // 점수순 정렬 후 반환
    final sortedResults = results.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedResults.map((e) => e.key).take(10).toList();
  }

  /// 단어 삭제
  void delete(String word) {
    if (word.isEmpty) return;

    final lowercaseWord = word.toLowerCase();
    _deleteRecursive(_root, lowercaseWord, 0);
  }

  /// 단어 삭제 재귀 함수
  bool _deleteRecursive(TrieNode node, String word, int index) {
    if (index == word.length) {
      if (!node.isEndOfWord) return false;
      node.isEndOfWord = false;
      node.words.removeWhere((w) => w.toLowerCase() == word);
      return node.children.isEmpty;
    }

    final char = word[index];
    final childNode = node.children[char];
    if (childNode == null) return false;

    final shouldDeleteChild = _deleteRecursive(childNode, word, index + 1);

    if (shouldDeleteChild) {
      node.children.remove(char);
      return node.children.isEmpty && !node.isEndOfWord;
    }

    return false;
  }

  /// Trie 초기화 (DB에서 단어들을 가져와서 삽입)
  Future<void> initialize(List<String> words) async {
    if (_isInitialized) return;

    // 기존 Trie 초기화
    _root = TrieNode();

    // 단어들 삽입
    for (final word in words) {
      insert(word);
    }

    _isInitialized = true;
  }

  /// Trie 초기화 상태 리셋
  void reset() {
    _root = TrieNode();
    _isInitialized = false;
  }

  /// 전체 단어 수 반환
  int get wordCount {
    return _getWordCountRecursive(_root);
  }

  /// 전체 단어 수 계산 재귀 함수
  int _getWordCountRecursive(TrieNode node) {
    int count = node.isEndOfWord ? 1 : 0;
    for (final child in node.children.values) {
      count += _getWordCountRecursive(child);
    }
    return count;
  }

  /// 디버깅용: Trie 구조 출력
  void printTrie() {
    _printTrieRecursive(_root, '');
  }

  /// 디버깅용: Trie 구조 출력 재귀 함수
  void _printTrieRecursive(TrieNode node, String prefix) {
    if (node.isEndOfWord) {
      print('$prefix -> ${node.words}');
    }
    for (final entry in node.children.entries) {
      _printTrieRecursive(entry.value, prefix + entry.key);
    }
  }
}
