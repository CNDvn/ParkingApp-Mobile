import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/model/request/push_notify_req.dart';
import 'package:parkingappmobile/model/response/push_notify.res.dart';
import 'package:parkingappmobile/repository/push_notify_rep.dart';

class PushNotifyImp implements PushNotifyRepo {
  @override
  Future<PushNotifyRes> pushNotify(
      String url, String accessToken, PushNotifyReq req) async {
    var result = PushNotifyRes();
    try {
      Response response = await Dio().put(url,
          data: req.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
    } catch (e) {}
    return result;
  }
}
