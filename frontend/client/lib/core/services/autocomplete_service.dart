import 'autocomplete_trie.dart';

/// 자동완성 서비스 클래스
/// DB에서 단어들을 가져와서 Trie를 초기화하고 관리
class AutocompleteService {
  static final AutocompleteService _instance = AutocompleteService._internal();
  factory AutocompleteService() => _instance;
  AutocompleteService._internal();

  final AutocompleteTrie _trie = AutocompleteTrie();

  /// 싱글톤 인스턴스
  static AutocompleteService get instance => _instance;

  /// Trie 초기화 상태 확인
  bool get isInitialized => _trie.isInitialized;

  /// 서비스 초기화 (DB에서 단어들을 가져와서 Trie 구축)
  Future<void> initialize() async {
    if (_trie.isInitialized) return;

    try {
      // TODO: 실제 DB 연동 시 이 부분을 수정
      // final words = await _fetchWordsFromDatabase();
      final words = await _getMockWords(); // 임시로 목 데이터 사용

      await _trie.initialize(words);
      print('AutocompleteTrie 초기화 완료: ${_trie.wordCount}개 단어');
    } catch (e) {
      print('AutocompleteTrie 초기화 실패: $e');
      rethrow;
    }
  }

  /// DB에서 단어들을 가져오는 메서드 (실제 구현 필요)
  Future<List<String>> _fetchWordsFromDatabase() async {
    // TODO: 실제 DB 연동 구현
    // 예시:
    // final db = await DatabaseHelper.instance.database;
    // final result = await db.query('autocomplete_words', columns: ['word']);
    // return result.map((row) => row['word'] as String).toList();

    throw UnimplementedError('DB 연동이 필요합니다');
  }

  /// 임시 목 데이터 (테스트용)
  Future<List<String>> _getMockWords() async {
    // 실제 DB 연동 전까지 사용할 테스트 데이터
    return [
      // 전자기기
      "휴대폰", "스마트폰", "핸드폰", "노트북", "태블릿", "이어폰", "에어팟", "무선이어폰",
      "충전기", "보조배터리", "USB", "SD카드", "카메라", "디카", "전자사전",

      // 지갑/카드/현금
      "지갑", "카드지갑", "신용카드", "체크카드", "교통카드", "학생증", "신분증", "주민등록증",
      "운전면허증", "현금", "동전", "지폐", "여권",

      // 가방/소지품
      "가방", "백팩", "에코백", "쇼핑백", "서류가방", "파우치", "필통", "우산", "텀블러", "물병",
      "책", "노트", "다이어리", "수첩",

      // 의류/패션
      "옷", "자켓", "코트", "점퍼", "모자", "캡모자", "비니", "장갑", "목도리", "신발", "운동화",
      "슬리퍼", "양말", "벨트", "안경", "선글라스", "시계",

      // 기타
      "열쇠", "자동차키", "집열쇠", "사물함키", "명찰", "출입증", "약", "약통", "립밤", "화장품",
      "쿠션", "거울", "빗", "머리끈", "머리핀", "담배", "라이터",

      // Apple
      "애플", "Apple", "아이폰", "iPhone", "아이패드", "iPad", "맥북", "MacBook", "에어팟",
      "AirPods", "애플워치", "Apple Watch", "에어팟 프로", "에어팟 맥스",

      // Samsung
      "삼성", "Samsung", "삼성 갤럭시", "삼성 스마트폰", "갤럭시", "Galaxy", "갤럭시S", "갤럭시노트",
      "갤럭시탭", "갤럭시버즈", "Galaxy Buds", "갤럭시워치", "Galaxy Watch", "버즈",

      // LG
      "LG", "LG그램", "그램", "LG노트북", "LG폰",

      // Sony
      "소니", "Sony", "소니헤드폰", "WH-1000XM5", "WH-1000XM4", "소니이어폰", "WF-1000XM4",
      "플스", "플레이스테이션", "PlayStation", "PS5", "PS4",

      // Microsoft
      "마이크로소프트", "Microsoft", "서피스", "Surface", "Xbox", "엑스박스",

      // Bose
      "보스", "Bose", "QC45", "QC35", "Bose Earbuds",

      // 카메라 브랜드 및 제품
      "캐논", "Canon", "니콘", "Nikon", "후지필름", "Fujifilm", "EOS", "D5600",
      "Z50", "X100V", "인스탁스", "Instax",

      // Gucci
      "구찌", "Gucci", "구찌지갑", "구찌가방", "구찌벨트", "구찌카드지갑", "구찌신발",

      // Louis Vuitton
      "루이비통", "Louis Vuitton", "비통지갑", "비통가방", "비통카드지갑", "비통클러치",

      // Prada
      "프라다", "Prada", "프라다가방", "프라다지갑", "프라다카드지갑",

      // Chanel
      "샤넬", "Chanel", "샤넬가방", "샤넬지갑", "샤넬카드지갑", "샤넬향수",

      // Coach
      "코치", "Coach", "코치가방", "코치지갑", "코치카드지갑",

      // MCM
      "MCM", "엠씨엠", "MCM가방", "MCM지갑", "MCM카드지갑",

      // Montblanc
      "몽블랑", "Montblanc", "몽블랑펜", "몽블랑지갑", "몽블랑시계",

      // Rolex
      "롤렉스", "Rolex", "롤렉스시계", "서브마리너", "데이토나", "데이트저스트",

      // Omega
      "오메가", "Omega", "오메가시계", "스피드마스터", "씨마스터",

      // Cartier
      "까르띠에", "Cartier", "까르띠에시계", "러브팔찌", "저스트앵끌루",

      // Tiffany
      "티파니", "Tiffany", "티파니앤코", "티파니목걸이", "티파니반지",

      // Samsonite
      "쌤소나이트", "Samsonite", "쌤소나이트캐리어", "쌤소나이트가방",

      // Rimowa
      "리모와", "Rimowa", "리모와캐리어",

      // 기타 명품 브랜드
      "발렌시아가", "Balenciaga", "발렌티노", "Valentino", "셀린느", "Celine",
      "버버리", "Burberry", "에르메스", "Hermes", "페라가모", "Ferragamo", "토리버치",
      "Tory Burch", "폴로", "Polo", "라코스테", "Lacoste",
    ];
  }

  /// 자동완성 검색
  List<String> search(String query) {
    if (!_trie.isInitialized) {
      print('AutocompleteTrie가 초기화되지 않았습니다.');
      return [];
    }

    if (query.isEmpty) return [];

    return _trie.search(query);
  }

  /// 접두사 검색
  List<String> searchByPrefix(String prefix) {
    if (!_trie.isInitialized) return [];
    return _trie.searchByPrefix(prefix);
  }

  /// 접미사 검색
  List<String> searchBySuffix(String suffix) {
    if (!_trie.isInitialized) return [];
    return _trie.searchBySuffix(suffix);
  }

  /// 중간 글자 검색
  List<String> searchBySubstring(String substring) {
    if (!_trie.isInitialized) return [];
    return _trie.searchBySubstring(substring);
  }

  /// 한국어 초성 검색
  List<String> searchByKoreanInitial(String initialQuery) {
    if (!_trie.isInitialized) return [];
    return _trie.searchByKoreanInitial(initialQuery);
  }

  /// 단어 추가 (실시간 업데이트)
  Future<void> addWord(String word) async {
    if (word.isEmpty) return;

    _trie.insert(word);

    // TODO: DB에도 추가
    // await _addWordToDatabase(word);

    print('단어 추가됨: $word');
  }

  /// 단어 삭제 (실시간 업데이트)
  Future<void> removeWord(String word) async {
    if (word.isEmpty) return;

    _trie.delete(word);

    // TODO: DB에서도 삭제
    // await _removeWordFromDatabase(word);

    print('단어 삭제됨: $word');
  }

  /// DB에 단어 추가 (실제 구현 필요)
  Future<void> _addWordToDatabase(String word) async {
    // TODO: 실제 DB 연동 구현
    // final db = await DatabaseHelper.instance.database;
    // await db.insert('autocomplete_words', {'word': word});
  }

  /// DB에서 단어 삭제 (실제 구현 필요)
  Future<void> _removeWordFromDatabase(String word) async {
    // TODO: 실제 DB 연동 구현
    // final db = await DatabaseHelper.instance.database;
    // await db.delete('autocomplete_words', where: 'word = ?', whereArgs: [word]);
  }

  /// 전체 단어 수 반환
  int get wordCount {
    return _trie.wordCount;
  }

  /// 서비스 리셋 (테스트용)
  void reset() {
    _trie.reset();
  }

  /// 디버깅용: Trie 구조 출력
  void printTrie() {
    if (_trie.isInitialized) {
      _trie.printTrie();
    } else {
      print('Trie가 초기화되지 않았습니다.');
    }
  }
}
