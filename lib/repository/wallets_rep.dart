import 'package:parkingappmobile/model/response/get_wallet_res.dart';

abstract class WalletRepo {
  Future<GetWalletRes> getWallet(String url, String accessToken);
}
