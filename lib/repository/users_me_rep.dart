import 'package:parkingappmobile/model/response/users_me_res.dart';

abstract class UsersMeRepo {
  Future<UsersMeRes> getUsersMe(String url, String accessToken);
}