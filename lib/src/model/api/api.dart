class ApiEndPoints {
  static final String baseUrl = 'http://qltcapi.tasvietnam.vn/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();

}

class _AuthEndPoints {
  final String registerPhone = 'authaccount/registration';
  final String loginPhone = 'user/login';
}
