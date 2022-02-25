import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/profile_req.dart';
import 'package:parkingappmobile/model/response/profile_res.dart';
import 'package:parkingappmobile/repository/profile_rep.dart';

class ProfileRepImpl implements ProfileRepo {
  @override
  Future<ProfileRes> putProfile(
      String url, ProfileReq req, String accessToken) async {
    var result = ProfileRes();
    try {
      Response response = await Dio().put(url,
          data: req.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = ProfileRes.profileResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
