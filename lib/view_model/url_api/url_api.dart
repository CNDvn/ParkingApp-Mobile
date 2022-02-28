class UrlApi {
  static const String serverPath = "https://parking-app-project.herokuapp.com/api/v1";
  static const String signinPath = '$serverPath/auths/login';
  static const String otpPath = '$serverPath/auths/OTPSMS';
  static const String resetpasswordPath = '$serverPath/auths/resetPassword';
  static const String usersMePath = 'https://parking-app-project.herokuapp.com/api/v1/users/me';
  static const String getAllParkings = '$serverPath/parkings?sizePage=100&currentPage=1&sort=ASC';
}