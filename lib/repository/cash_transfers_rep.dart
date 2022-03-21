import 'package:parkingappmobile/model/request/cash_transfers_req.dart';
import 'package:parkingappmobile/model/response/cash_transfers_res.dart';

abstract class CashTransfersRep {
  Future<CashTransfersRes> postTransfers(String url, CashTransfersReq req , String accessToken);
}