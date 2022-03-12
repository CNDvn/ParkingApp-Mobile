class UrlApi {
  static const String serverPath = "https://parking-app-project.herokuapp.com/api/v1";
  static const String signinPath = '$serverPath/auths/login';
  static const String otpPath = '$serverPath/auths/OTPSMS';
  static const String resetpasswordPath = '$serverPath/auths/resetPassword';
  static const String signupPath = '$serverPath/auths/customer';
  static const String verifyOTPPath = '$serverPath/auths/verifyOTPSignUp';
  static const String usersMePath = '$serverPath/users/me';
  static const String changePasswordPath = '$serverPath/auths/password';
  static const String getAllParkings = '$serverPath/parkings?sizePage=100&currentPage=1&sort=ASC';
  static const String imagesPath = '$serverPath/images';
  static const String typeCarsPath = '$serverPath/type-cars';
  static const String carsPath = '$serverPath/cars';
  static const String profilePath = '$serverPath/users/profile';
  static const String signoutPath = '$serverPath/auths/logout';
  static const String loginGooglePath = '$serverPath/auths/loginGoogle';
  static const String userCar = '$serverPath/cars/me';
}