import 'package:parkingappmobile/model/response/history_res.dart';

abstract class HistoryRepo {
  Future<HistoryRes> getHistory(String url, String accessToken);
}