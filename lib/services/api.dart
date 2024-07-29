class ApiEndPoints {
  static const String baseUrl = 'http://qltcapi.tasvietnam.vn/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();

}

class _AuthEndPoints {
  final String loginPhone = 'user/login';
  final String registerPhone = 'user/Register';
}
