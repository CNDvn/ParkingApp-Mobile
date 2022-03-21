class UrlApi {
  static const String serverPath = "https://parkingappbe.eastasia.cloudapp.azure.com/api/v1";
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
  static const String cardCarPath = '$serverPath/cars/me';
  static const String userCar = '$serverPath/cars/me';
  static const String cardsPath = '$serverPath/cards';
  static const String pushNotify = '$serverPath/push-notification/deviceToken';
  static const String signOut = "$serverPath/auths/logout";
  static const String historyPath = "$serverPath/historys/me/car";
  static const String walletPath = "$serverPath/wallets/me";
  static const String banksPath = "$serverPath/banks";
  static const String cashTransfersPath = "$serverPath/cashTransfers/transfer";
}