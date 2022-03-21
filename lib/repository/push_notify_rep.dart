import 'package:parkingappmobile/model/request/push_notify_req.dart';
import 'package:parkingappmobile/model/response/push_notify.res.dart';

abstract class PushNotifyRepo {
  Future<PushNotifyRes> pushNotify(
      String url, String accessToken, PushNotifyReq req);
}
