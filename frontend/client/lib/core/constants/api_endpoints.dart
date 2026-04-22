class ApiEndpoints {
  // Base URL은 환경에 맞게 설정하세요 (예: .env 또는 빌드 설정)
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: '');

  // Version
  static const String version = 'v1';

  // Path
  static const String path = '$baseUrl/api/$version';

  // User
  static const String userSignup = '/user/signup';
  static const String userLogin = '/user/login';
  static const String userLogout = '/user/logout';
  static const String userDelete = '/user/delete';
  static const String userVerify = '/user/verify';
  // static const String authRefresh = '$path/auth/refresh';

  // Search
  static const String search = '/search';

  // Item
  static const String itemList = '/item/list';
  static const String itemDetail = '/item/detail/{item_id}';
  static const String itemSearch = '/item/search';
  static const String reportItemList = '/item/my';
  static const String reportItem = '/item/report';
  static const String reportItemUpdate = '/item/report/update/{item_id}';
  static const String reportItemDelete = '/item/report/delete/{item_id}';

  static const String itemPickup = '/item/pickup/{item_id}';
  static const String itemPickupCancel = '/item/pickup/cancel/{item_id}';
  static const String itemPickupFailure = '/item/pickup/failure';
  static const String itemPickupConfirm = '/item/pickup/confirm';

  // robot
  static const String robotLocation = '/robot/location';
}
