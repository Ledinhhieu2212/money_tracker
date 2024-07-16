class ApiEndPoints {
  static final String baseUrl = 'http://base_url/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();

}

class _AuthEndPoints {
  final String registerEmail = 'authaccount/registration';
  final String loginEmail = 'authaccount/login';
}
