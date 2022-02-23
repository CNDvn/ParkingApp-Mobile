import 'package:parkingappmobile/model/response/parking_res.dart';

abstract class ParkingRepo {
  Future<ParkingsRes> getParkings(String url);
}