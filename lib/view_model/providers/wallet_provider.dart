import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/request/cash_transfers_req.dart';
import 'package:parkingappmobile/repository/impl/cash_transfers_rep_impl.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletProvider with ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();
  String? dropdownValue;
  final _priceTextEditController = TextEditingController();
  TextEditingController get priceController => _priceTextEditController;
  String get textPrice => priceController.text;
  bool submitValid = false;

  void submitData(BuildContext context) async {
    String accessToken = await secureStorage.readSecureData("token");
    if (textPrice.isEmpty) {
      showToastFail("Price is empty");
    } else if (!RegExp('^\$|^(0|([1-9][0-9]{0,9}))(\\.[0-9]{0,3})?\$')
        .hasMatch(textPrice)) {
      showToastFail("Price invalid");
    } else {
      CashTransfersRepImpl()
          .postTransfers(
              UrlApi.cashTransfersPath,
              CashTransfersReq(
                  amount: int.parse(textPrice), bankId: dropdownValue!),
              accessToken)
          .then((value) async {
        await launch(
          value.result!,
          forceSafariVC: false,
        );
        priceController.clear();
        priceController.text = "";
      });
      showToastSuccess("Success");
    }
  }
}
