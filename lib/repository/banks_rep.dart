import 'package:parkingappmobile/model/response/banks_res.dart';

abstract class BanksRep {
  Future<BanksRes> getBanks(String url, String accessToken);
}