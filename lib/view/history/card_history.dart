import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/model/response/history_res.dart';

// ignore: must_be_immutable
class CardHistory extends StatelessWidget {
  Result? history;
  CardHistory({Key? key, this.history, required this.isComplete})
      : super(key: key);
  final bool isComplete;
  @override
  Widget build(BuildContext context) {
    final format = NumberFormat("#,##0,000");
    final formatDetail = NumberFormat("#,##0,000.000");

    String daysBetween(DateTime startDate, DateTime endDate) {
      int seconds = endDate.difference(startDate).inSeconds;
      if (seconds < 60) {
        return '$seconds second';
      } else if (seconds >= 60 && seconds < 3600) {
        return '${endDate.difference(startDate).inMinutes.abs()} minute';
      } else if (seconds >= 3600 && seconds < 86400) {
        return '${endDate.difference(startDate).inHours} hour';
      } else {
        return '${endDate.difference(startDate).inDays} day';
      }
    }

    final date1 = history != null ? DateTime.parse(history!.startTime) : DateTime.now();
    final date2 = history?.payment.id == history?.car.id
        ? DateTime.now()
        : DateTime.parse(history!.payment.endTime);

    final difference = daysBetween(date1, date2);

    Size size = MediaQuery.of(context).size;
    return history == null
        ? const Text('')
        : Card(
            child: Column(children: [
              ListTile(
                // leading: Icon(Icons.album),
                title: Container(
                  padding: EdgeInsets.fromLTRB(
                      0, size.height * 0.01, 0, size.height * 0.0001),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        color: Colors
                            .white, // This line set the transparent background
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (isComplete)
                                Icon(
                                  Icons.check,
                                  color: AppColor.greenToast,
                                  size: 24.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                              Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: AppColor.lightButton,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0))),
                                  child: Center(
                                    child: Text(format
                                            .format(double.parse(history!.price
                                                .substring(0,
                                                    history!.price.length - 4)))
                                            .toString() +
                                        " /1h"),
                                  )),
                            ]),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            history!.parking.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                height: 1.6),
                          ),
                          Text(
                            'Location-' +
                                history!.parkingSlot.locationName.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.6),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                subtitle: Container(
                  padding: EdgeInsets.fromLTRB(
                      0, size.height * 0.01, 0, size.height * 0.01),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, size.height * 0.01, 0, size.height * 0.02),
                      child: const Divider(
                        height: 2,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          !isComplete ? "Total Timing" : "Total Money",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              height: 1.6),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.access_alarm,
                              color: AppColor.lightButton,
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            Text(
                              // ignore: prefer_adjacent_string_concatenation
                              !isComplete
                                  ? difference
                                  : difference +
                                      " - " +
                                      formatDetail
                                          .format(double.parse(
                                              history?.payment.id ==
                                                      history?.car.id
                                                  ? '0'
                                                  : history!.payment.amount))
                                          .toString() +
                                      " đ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  height: 1.6),
                            )
                          ],
                        )
                      ],
                    )
                  ]),
                ),
              ),
            ]),
          );
  }
}
