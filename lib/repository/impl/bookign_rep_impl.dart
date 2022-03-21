import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/booking_by_idcar_res.dart';
import 'package:parkingappmobile/model/response/booking_res.dart';
import 'package:parkingappmobile/model/response/checkout_res.dart';
import 'package:parkingappmobile/repository/booking_rep.dart';
import 'package:parkingappmobile/model/response/book_cancel_res.dart';

class BookingRepImpl implements BookingRep {
  @override
  Future<BookingRes> postBooking(String url, String accessToken) async {
    var result = BookingRes();
    try {
      Response response = await Dio().post(url,options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
      result = BookingRes.bookingResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<CheckoutRes> postCheckOut(String url, String accessToken) async {    
    var result = CheckoutRes();
    try {
      Response response = await Dio().post(url,options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
      result = CheckoutRes.checkoutResFromJson(jsonEncode(response.data));
    // ignore: unused_catch_clause
    }on DioError catch (e) {
      showToastFail("Not Yet Check-in ");
    }
    return result;
  }

  @override
  Future<BookingByIdCarRes> getBookingByIdCar(String url, String accessToken) async {
    var result = BookingByIdCarRes();
    try {
      Response response = await Dio().get(url,options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
      result = BookingByIdCarRes.bookingByIdCarResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<BookCancelRes> putBookCancelByIdCar(String url, String accessToken) async {
    var result = BookCancelRes();
    try {
      Response response = await Dio().put(url,options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
      result = BookCancelRes.bookCancelResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<void> putBookCancelByIdCar1(String url, String accessToken) async {
    try {
      Response response = await Dio().put(url,options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
      if (response.data !=null) {
        showToastSuccess("Cancel Successful");
      }
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
  }

}