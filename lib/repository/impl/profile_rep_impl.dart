import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/profile_req.dart';
import 'package:parkingappmobile/model/response/profile_res.dart';
import 'package:parkingappmobile/repository/profile_rep.dart';

class ProfileRepImpl implements ProfileRepo {
  @override
  Future<ProfileRes> putProfile(String url, ProfileReq req) async {
    var result = ProfileRes();
    try {
      Response response = await Dio().put(url, data: req.toJson());
      result = ProfileRes.profileResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
