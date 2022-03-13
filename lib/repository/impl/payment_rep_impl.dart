import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/payment_res.dart';
import 'package:parkingappmobile/repository/payment_rep.dart';

class PaymentRepImpl extends PaymentRep {
  @override
  Future<PaymentRes> postPayment(String url, String accessToken) async {
    var result = PaymentRes();
    try {
      Response response = await Dio().post(url,options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
      result = PaymentRes.paymentResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}