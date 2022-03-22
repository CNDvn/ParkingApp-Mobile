import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/model/response/history_res.dart';
import 'package:parkingappmobile/repository/impl/history_rep_impl.dart';
import 'package:parkingappmobile/view/history/history.dart';

import '../../model/entity/car.dart';
import '../../view_model/service/service_storage.dart';
import '../../view_model/url_api/url_api.dart';

// ignore: must_be_immutable
class CardCarHistory extends StatefulWidget {
  CardCarHistory({Key? key, this.car}) : super(key: key);
  Car? car;

  @override
  State<CardCarHistory> createState() => _CardCarHistoryState();
}

class _CardCarHistoryState extends State<CardCarHistory> {
  List<Result>? listHistory = [];
  @override
  void initState() {
    super.initState();
    final SecureStorage secureStorage = SecureStorage();
    secureStorage.readSecureData("token").then((token) => {
          HistoryRepImp()
              .getHistory(UrlApi.historyPath + "/${widget.car!.id}", token)
              .then((value) {
            setState(() {
              listHistory = value.result;
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return History(
              history: listHistory,
            );
          }),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Image.network(
                  widget.car!.images.isEmpty
                      ? "https://i.ibb.co/GMv63Nr/e391ff1ef747.png"
                      : widget.car!.images[0].url,
                  width: 100,
                  height: 100,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.car!.brand),
                    Text(
                      widget.car!.status.toUpperCase(),
                      style: TextStyle(
                          color: widget.car!.status == "booked"
                              ? AppColor.redToast
                              : AppColor.greenToast,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                subtitle: SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.car!.modelCode),
                      Text(widget.car!.nPlates),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
