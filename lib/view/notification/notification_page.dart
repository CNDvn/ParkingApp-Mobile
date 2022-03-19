import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/notification/notification_card_page.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key, required this.notifications})
      : super(key: key);
  final List<String> notifications;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerDefault(),
      body: Column(children: [
        if (notifications.isNotEmpty)
          for (var notification in notifications)
            Container(
              padding: EdgeInsets.all(size.width * 0.02),
              child: NotificationCardPage(
                notification: notification,
              ),
            ),
      ]),
    );
  }
}
