import 'package:parkingappmobile/model/response/booking_by_idcar1_res.dart';
import 'package:parkingappmobile/model/response/booking_by_idcar_res.dart';
import 'package:parkingappmobile/model/response/booking_res.dart';
import 'package:parkingappmobile/model/response/checkout_res.dart';

abstract class BookingRep {
  Future<BookingRes> postBooking(String url, String accessToken);
  Future<CheckoutRes> postCheckOut(String url, String accessToken);
  Future<BookingByIdCarRes1> getBookingByIdCar1(String url, String accessToken);
  Future<BookingByIdCarRes> getBookingByIdCar(String url, String accessToken);
}