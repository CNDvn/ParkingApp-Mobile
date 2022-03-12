import 'package:parkingappmobile/model/response/car_detail_res.dart';
import 'package:parkingappmobile/model/response/card_car_res.dart';

abstract class CardCarRepo {
  Future<CardCarRes> getCardCar(String url, String token);
  Future<CarDetailRes> getCarDetail(String url);
}