import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/repository/impl/wallet_rep_impl.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';

import '../../model/response/get_wallet_res.dart';

// ignore: must_be_immutable
class CardPayment extends StatefulWidget {
  CardPayment({Key? key, this.wallet}) : super(key: key);
  Result? wallet;

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  final formatDetail = NumberFormat("#,##0,000");

  @override
  Widget build(BuildContext context) {
    final SecureStorage secureStorage = SecureStorage();
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.blueGrey,
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("My Wallet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 1.6))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("* * * *",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 2)),
                  Text("* * * *",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 2)),
                  Text("* * * *",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 2)),
                  Text("* * * *",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 2)),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Current balance",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 1.6)),
                  Text(
                      widget.wallet?.currentBalance != null
                          ? formatDetail.format(double.parse(
                                  widget.wallet!.currentBalance!)) +
                              " VND"
                          : "",
                      // card.dateValidFrom,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 1.6))
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Frozen Money",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 1.6)),
                  Text(
                      widget.wallet?.frozenMoney != null
                          ? formatDetail.format(
                                  double.parse(widget.wallet!.frozenMoney!)) +
                              " VND"
                          : "",
                      // card.dateValidFrom,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 1.6))
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  secureStorage.readSecureData("token").then((token) => {
                        WalletRepImpl()
                            .getWallet(UrlApi.walletPath, token)
                            .then((value) async {
                          setState(() {
                            widget.wallet = value.result;
                          });
                        })
                      });
                },
                child: Icon(
                  Icons.refresh,
                  size: 36,
                  color: AppColor.whiteText,
                ),
              ),
            ]),
      ),
    );
  }
}
