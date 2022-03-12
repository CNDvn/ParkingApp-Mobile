import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';

class CardHistory extends StatelessWidget {
  const CardHistory({Key? key, required this.isComplete}) : super(key: key);
  final bool isComplete;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
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
                  color:
                      Colors.white, // This line set the transparent background
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
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                color: AppColor.lightButton,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0))),
                            child: const Center(
                              child: Text("20k/1h"),
                            )),
                      ]),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'Bãi Gửi Xe Không Gian',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          height: 1.6),
                    ),
                    Text(
                      'Location-4c',
                      style: TextStyle(
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
                        fontWeight: FontWeight.w700, fontSize: 15, height: 1.6),
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
                        !isComplete ? "1h30p" : "1h30p - " + "30s.000đ",
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
