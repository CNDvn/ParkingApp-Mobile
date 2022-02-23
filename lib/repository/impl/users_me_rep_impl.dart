import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/sign_in_res.dart';
import 'package:parkingappmobile/model/response/users_me_res.dart';
import 'package:parkingappmobile/repository/users_me_rep.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';

class UsersMeRepImpl implements UsersMeRepo {
  @override
  Future<UsersMeRes> getUsersMe(String url, String accessToken) async {
    var result = SignInRes();
    var dataUsersMe = UsersMeRes();
    try {
      Response response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      dataUsersMe = UsersMeRes.usersMeResFromJson(jsonEncode(response.data));
      final SecureStorage secureStorage = SecureStorage();
      secureStorage.writeSecureData("fullname", dataUsersMe.result!.fullName);
      secureStorage.writeSecureData("emailAddress", dataUsersMe.result!.email);
      secureStorage.writeSecureData("phoneNumber", dataUsersMe.result!.phoneNumber);
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return dataUsersMe;
  }
}