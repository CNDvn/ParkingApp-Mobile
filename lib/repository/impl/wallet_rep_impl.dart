import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/get_wallet_res.dart';
import 'package:parkingappmobile/repository/wallets_rep.dart';

class WalletRepImpl implements WalletRepo {
  @override
  Future<GetWalletRes> getWallet(String url, String accessToken) async {
    var result = GetWalletRes();
    try {
      Response response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = GetWalletRes.getWalletResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
