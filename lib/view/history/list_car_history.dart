import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/history/card_car_history.dart';

import '../../model/entity/car.dart';
import '../../repository/impl/car_rep_impl.dart';
import '../../view_model/service/service_storage.dart';
import '../../view_model/url_api/url_api.dart';

class ListCarHistory extends StatefulWidget {
  const ListCarHistory({Key? key}) : super(key: key);

  @override
  State<ListCarHistory> createState() => _ListCarHistoryState();
}

class _ListCarHistoryState extends State<ListCarHistory> {
  List<Car>? listCar = [];
  @override
  void initState() {
    super.initState();
    final SecureStorage secureStorage = SecureStorage();
    secureStorage.readSecureData("token").then((token) => {
          CarRepImpl().getCardCar(UrlApi.cardCarPath, token).then((value) {
            setState(() {
              listCar = value.result;
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                0, size.height * 0.05, 0, size.height * 0.05),
          ),
          const Text(
            "Your Car's History",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
          ),
          SizedBox(
            height: 0.7 * size.height,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listCar?.length,
              itemBuilder: (context, index) {
                return CardCarHistory(
                  car: listCar![index],
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
