import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/banks_res.dart';
import 'package:parkingappmobile/repository/banks_rep.dart';

class BankRepImpl implements BanksRep {
  @override
  Future<BanksRes> getBanks(String url, String accessToken) async {
    var result = BanksRes();
    try {
      Response response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = BanksRes.banksResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
