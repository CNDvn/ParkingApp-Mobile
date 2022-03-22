import 'package:flutter/material.dart';
import 'package:parkingappmobile/model/response/banks_res.dart';
import 'package:parkingappmobile/model/response/get_wallet_res.dart';
import 'package:parkingappmobile/repository/impl/banks_rep_impl.dart';
import 'package:parkingappmobile/repository/impl/wallet_rep_impl.dart';
import 'package:parkingappmobile/view/payments/card_payment.dart';
import 'package:parkingappmobile/view_model/providers/wallet_provider.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:provider/provider.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  Result wallet = Result();
  List<ResultBanks> listBank = [];
  ResultBanks bank = ResultBanks();
  @override
  void initState() {
    super.initState();
    WalletProvider provider =
        Provider.of<WalletProvider>(context, listen: false);
    final SecureStorage secureStorage = SecureStorage();
    secureStorage.readSecureData("token").then((token) => {
          WalletRepImpl().getWallet(UrlApi.walletPath, token).then((value) {
            setState(() {
              wallet = value.result!;
            });
          })
        });
    secureStorage.readSecureData("token").then((token) => {
          BankRepImpl().getBanks(UrlApi.banksPath, token).then((value) {
            setState(() {
              listBank = value.result!;
              provider.dropdownValue = listBank[0].id!;
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    WalletProvider provider = Provider.of<WalletProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            const Text(
              "Your Wallet",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
            ),
            Column(
              children: [
                Text(
                  'Choose a bank: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                // ignore: unnecessary_null_comparison
                if (listBank != null)
                  SizedBox(
                    width: size.width,
                    child: DropdownButton(
                      value: provider.dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: listBank.map((ResultBanks items) {
                        return DropdownMenuItem(
                          value: items.id,
                          child: Text(items.name!),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          provider.dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height * 0.12,
                  width: size.width * 0.5,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: "Amount to deposit"),
                    controller: provider.priceController,
                    autofocus: false,
                  ),
                ),
                const Text(" VND"),
                ElevatedButton(
                  onPressed: () {
                    provider.submitData(context);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 36,
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            SizedBox(
              child: CardPayment(wallet: wallet),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    ));
  }
}
