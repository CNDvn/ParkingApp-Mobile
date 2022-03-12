import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/card_res.dart';
import 'package:parkingappmobile/repository/card_payment_rep.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';

class CardPaymentRepImp implements CardRepo {
  @override
  Future<ListCard> getListCardMe(String url) async {
    var result = ListCard();
    final SecureStorage secureStorage = SecureStorage();
    try {
      final accessToken = await secureStorage.readSecureData("token");
      Response response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = ListCard.listCardFromJson(jsonEncode(response.data));
    } catch (e) {
      showToastFail(e.toString());
    }
    return result;
  }
}
