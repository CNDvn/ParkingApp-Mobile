import 'package:parkingappmobile/model/request/create_car_req.dart';
import 'package:parkingappmobile/model/request/upload_car_req.dart';
import 'package:parkingappmobile/model/response/card_car_res.dart';
import 'package:parkingappmobile/model/response/create_car_res.dart';
import 'package:parkingappmobile/model/response/mycar_res.dart';
import 'package:parkingappmobile/model/response/type_cars_res.dart';
import 'package:parkingappmobile/model/response/upload_car_res.dart';

abstract class CarRepo {
  Future<TypeCarsRes> getTypeCars(String url, String token);
  Future<CreateCarRes> postCar(String url, CreateCarReq req, String token);
  Future<CardCarRes> getCardCar(String url, String token);
  Future<UploadCarRes> putCardCar(String url, UploadCarReq req, String token);
  Future<MyCarRes> getMyCar(String url, String token);
}