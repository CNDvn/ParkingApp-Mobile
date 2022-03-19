import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/history_res.dart';
import 'package:parkingappmobile/repository/history_rep.dart';

class HistoryRepImp implements HistoryRepo {
  @override
  Future<HistoryRes> getHistory(String url, String accessToken) async {
    var result = HistoryRes();
    try {
      Response response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = HistoryRes.historyResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
