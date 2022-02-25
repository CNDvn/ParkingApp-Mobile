class UrlApi {
  static const String serverPath = "https://parking-app-project.herokuapp.com/api/v1";
  static const String signinPath = '$serverPath/auths/login';
  static const String usersMePath = '$serverPath/api/v1/users/me';
  static const String getAllParkings = '$serverPath/parkings?sizePage=5&currentPage=1&sort=ASC';
  static const String profilePath = '$serverPath/api/v1/users/profile';
}