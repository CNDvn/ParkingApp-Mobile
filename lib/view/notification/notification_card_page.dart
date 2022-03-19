import 'package:flutter/material.dart';

class NotificationCardPage extends StatelessWidget {
  const NotificationCardPage({Key? key, required this.notification})
      : super(key: key);
  final String notification;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<String> data = notification.split("|");
    String title = data[0];
    String content = data[1];
    String time = data[2].split(".")[0];
    return Container(
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Notification"),
            Text(time),
          ],
        ),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: size.width * 0.05),
        ),
        Text(content),
      ]),
    );
  }
}
