import 'package:parkingappmobile/model/response/parking_detail_res.dart';
import 'package:parkingappmobile/model/response/parking_res.dart';

abstract class ParkingRepo {
  Future<ParkingsRes> getParkings(String url);
  Future<ParkingDetailRes> getParkingDetail(String url);
}