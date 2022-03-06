class UrlApi {
  static const String serverPath = "https://parking-app-project.herokuapp.com/api/v1";
  static const String signinPath = '$serverPath/auths/login';
  static const String otpPath = '$serverPath/auths/OTPSMS';
  static const String resetpasswordPath = '$serverPath/auths/resetPassword';
  static const String signupPath = '$serverPath/auths/customer';
  static const String verifyOTPPath = '$serverPath/auths/verifyOTPSignUp';
  static const String usersMePath = 'https://parking-app-project.herokuapp.com/api/v1/users/me';
  static const String changePasswordPath = '$serverPath/auths/password';
  static const String getAllParkings = '$serverPath/parkings?sizePage=100&currentPage=1&sort=ASC';
  static const String profilePath = '$serverPath/users/profile';
  static const String signoutPath = '$serverPath/auths/logout';
}