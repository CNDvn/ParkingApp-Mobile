import 'package:parkingappmobile/model/response/payment_res.dart';

abstract class PaymentRep {
  Future<PaymentRes> postPayment(String url, String accessToken);
}