import 'package:parkingappmobile/model/request/create_car_req.dart';
import 'package:parkingappmobile/model/response/create_car_res.dart';
import 'package:parkingappmobile/model/response/type_cars_res.dart';

abstract class CarRepo {
  Future<TypeCarsRes> getTypeCars(String url, String token);
  Future<CreateCarRes> postCar(String url, CreateCarReq req, String token);
}