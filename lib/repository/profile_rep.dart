import 'package:parkingappmobile/model/response/profile_res.dart';
import 'package:parkingappmobile/model/request/profile_req.dart';

abstract class ProfileRepo {
  Future<ProfileRes> putProfile(String url, ProfileReq req, String accessToken);
}