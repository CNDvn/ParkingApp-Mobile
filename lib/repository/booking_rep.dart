import 'package:parkingappmobile/model/response/booking_res.dart';
import 'package:parkingappmobile/model/response/checkout_res.dart';

abstract class BookingRep {
  Future<BookingRes> postBooking(String url, String accessToken);
  Future<CheckoutRes> postCheckOut(String url, String accessToken);
}