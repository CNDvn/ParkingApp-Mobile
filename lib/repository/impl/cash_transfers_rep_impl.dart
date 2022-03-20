import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/cash_transfers_req.dart';
import 'package:parkingappmobile/model/response/cash_transfers_res.dart';
import 'package:parkingappmobile/repository/cash_transfers_rep.dart';

class CashTransfersRepImpl implements CashTransfersRep {
  @override
  Future<CashTransfersRes> postTransfers(
      String url, CashTransfersReq req, String accessToken) async {
    var result = CashTransfersRes();
    try {
      Response response = await Dio().post(url,
      data: req.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result =
          CashTransfersRes.cashTransfersResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
